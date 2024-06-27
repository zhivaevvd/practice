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
        tableView.top().left().right().bottom()
        configTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        items = []
        if dataService.appState.user?.type != .student {
            getGroups()
            selectedGroup = groups.first
            getSchedule(groupId: nil)
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
            groupsButton.setTitle(selectedGroup?.name, for: .normal)
        }
    }

    var items: [Schedule] = [] {
        didSet {
            snapshot(groupItemsByDate(items))
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
            case .failure:
                self?.snacker?.show(snack: L10n.Common.errorSimple, with: .error)
            }
        })
    }
    
    private func getGroups() {
        service?.getGroups(completion: { [weak self] result in
            switch result {
            case let .success(response):
                self?.groups = response.groups
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
