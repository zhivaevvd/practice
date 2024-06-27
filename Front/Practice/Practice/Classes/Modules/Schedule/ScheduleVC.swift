//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import AutoLayoutSugar
import Foundation
import OrderedDictionary
import UIKit

// MARK: - CatalogVC

final class ScheduleVC: UIViewController {
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: groupsButton)
        groupsButton.isHidden = dataService.appState.user?.type == .student
        title = L10n.Schedule.title
        view.addSubview(tableView)
        view.addSubview(emptyLabel)
        tableView.top().left().right().bottom()
        emptyLabel.center()
        configTableView()
        
        profileService.getProfile { [weak self] result in
            switch result {
            case let .success(profile):
                if profile.type != .student {
                    self?.getGroups()
                    if profile.type == .teacher {
                        DispatchQueue.main.async {
                            guard var controllers = self?.tabBarController?.viewControllers else {
                                return
                            }

                            controllers.remove(at: 1)
                            self?.tabBarController?.viewControllers = controllers
                        }
                    }
                } else {
                    self?.selectedGroup = nil
                    self?.getSchedule(groupId: profile.groupId)
                    DispatchQueue.main.async {
                        self?.groupsButton.isHidden = true
                        
                        guard var controllers = self?.tabBarController?.viewControllers else {
                            return
                        }

                        controllers.remove(at: 1)
                        self?.tabBarController?.viewControllers = controllers
                    }
                }
            default:
                break
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        items = []

        if profile?.type != .student {
            getGroups()
        } else {
            getSchedule(groupId: dataService.appState.user?.groupId)
        }
    }

    // MARK: Internal

    static let scheduleCellReuseId: String = ScheduleCell.description()

    var service: ScheduleService?

    var snacker: Snacker?
    
    var groups: [Group] = []
    
    var selectedGroup: Group? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                groupsButton.setTitle(selectedGroup?.name, for: .normal)
                if let id = selectedGroup?.id {
                    getSchedule(groupId: id)
                }
            }
        }
    }

    var items: [Schedule] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.snapshot(self.groupItemsByDate(items))
            }
        }
    }

    func groupItemsByDate(_ items: [Schedule]) -> [[Schedule]] {
        var groupedItems: OrderedDictionary<Date, [Schedule]> = [:]

        items.forEach { item in
            if groupedItems[item.date] != nil {
                groupedItems[item.date]?.append(item)
            } else {
                groupedItems[item.date] = [item]
            }
        }

        groupedItems.sort(by: { $0.key < $1.key })

        return Array(groupedItems.orderedValues)
    }

    func configTableView() {
        dataSource = UITableViewDiffableDataSource<SimpleDiffableSection, [Schedule]>(
            tableView: tableView,
            cellProvider: { [weak self] tableView, indexPath, model -> UITableViewCell? in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Self.scheduleCellReuseId,
                    for: indexPath
                ) as? ScheduleCell else {
                    return nil
                }
                cell.isEditable = self?.dataService.appState.user?.type == .admin
                cell.model = model
                cell.scheduleEditAction = { schedule in
                    guard let editScheduleController = VCFactory.buildCreateScheduleController(with: schedule) else {
                        return
                    }
                    self?.navigationController?.pushViewController(editScheduleController, animated: true)
                }
                return cell
            }
        )
    }

    func snapshot(_ items: [[Schedule]]) {
        var snapshot = NSDiffableDataSourceSnapshot<SimpleDiffableSection, [Schedule]>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    func loadFooterView(load: Bool) {
        if load {
            let view = UIView()
            view.frame.size = .init(width: view.frame.size.width, height: 60)
            view.startLoading(with: .smallBlue)
            tableView.tableFooterView = view
        } else {
            tableView.tableFooterView = UIView()
        }
    }

    // MARK: Private

    private enum SimpleDiffableSection: Int, Hashable {
        case main
    }

    private var dataSource: UITableViewDiffableDataSource<SimpleDiffableSection, [Schedule]>?

    private let dataService = CoreFactory.dataService
    
    private var profileService = CoreFactory.buildProfileService()
    
    private var profile: Profile?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(
            ScheduleCell.self,
            forCellReuseIdentifier: Self.scheduleCellReuseId
        )
        return tableView
    }()
    
    private lazy var groupsButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 10
        btn.height(25).width(100)
        btn.backgroundColor = .white
        btn.setTitle("Группы", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        btn.addTarget(self, action: #selector(openGroupSelection), for: .touchUpInside)
        return btn
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Пустое расписание"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = Asset.textSecondary.color
        return label
    }()

    private var isLoadingNextPage: Bool = false {
        didSet {
            loadFooterView(load: isLoadingNextPage)
        }
    }

    private func getSchedule(groupId: Int?) {
        let id = groupId ?? selectedGroup?.id
        service?.getSchedule(for: id, completion: { [weak self] result in
            switch result {
            case let .success(items):
                self?.items = items
                DispatchQueue.main.async {
                    self?.emptyLabel.isHidden = !items.isEmpty
                }
            case .failure:
                self?.snacker?.show(snack: L10n.Common.errorSimple, with: .error)
            }
        })
    }
    
    private func getGroups() {
        service?.getGroups(completion: { [weak self] result in
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self?.groups = response.groups
                    self?.selectedGroup = response.groups.first
                }
            case .failure:
                self?.snacker?.show(snack: L10n.Schedule.groupsError, with: .error)
            }
        })
    }
    
    @objc
    private func openGroupSelection() {
        let sheet = SelectSheet()
        sheet.selected = selectedGroup
        sheet.model = groups
        sheet.tapAction = { [weak self] item in
            guard let group = item as? Group else {
                return
            }
            
            self?.presentedViewController?.dismiss(animated: true, completion: {
                self?.selectedGroup = group
                self?.items = []
                self?.getSchedule(groupId: group.id)
            })
        }
        
        present(VCFactory.buildBottomSheetController(with: sheet, onEveryTapOut: {
            self.presentedViewController?.dismiss(animated: true)
        }), animated: true)
    }
}
