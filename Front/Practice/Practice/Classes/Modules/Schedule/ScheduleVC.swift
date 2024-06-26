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
        title = L10n.Schedule.title
        view.addSubview(tableView)
        tableView.top().left().right().bottom()
        configTableView()
        getSchedule()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        items = []
        getSchedule()
    }

    // MARK: Internal

    static let scheduleCellReuseId: String = ScheduleCell.description()

    var service: ScheduleService?

    var snacker: Snacker?

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
            cellProvider: { tableView, indexPath, model -> UITableViewCell? in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Self.scheduleCellReuseId,
                    for: indexPath
                ) as? ScheduleCell else {
                    return nil
                }
                cell.model = model
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

    private var isLoadingNextPage: Bool = false {
        didSet {
            loadFooterView(load: isLoadingNextPage)
        }
    }

    private func getSchedule() {
        service?.getSchedule(for: nil, completion: { [weak self] result in
            switch result {
            case let .success(items):
                self?.items = items
            case .failure:
                self?.snacker?.show(snack: L10n.Common.errorSimple, with: .error)
            }
        })
    }
}
