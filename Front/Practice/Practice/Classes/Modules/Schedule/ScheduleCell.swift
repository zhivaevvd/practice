//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class ScheduleCell: UITableViewCell {
    // MARK: Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureSubviews()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var scheduleEditAction: ((Schedule) -> Void)?

    // MARK: Internal

    var model: [Schedule] = [] {
        didSet {
            if let date = model.first?.date {
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "ru_RU")
                formatter.dateFormat = "d MMMM, EEEE"

                titleLabel.text = formatter.string(from: date)
            }
            containerStack.removeAllArrangedSubviews()

            for idx in 0 ... 6 {
                var view = UIView()
                if let pair = model.first(where: { $0.pairNumber == idx + 1 }) {
                    view = makeScheduleRow(pair, pairNumber: idx + 1)
                } else {
                    view = makeScheduleRow(pairNumber: idx + 1)
                }

                containerStack.addArrangedSubview(view)
            }
        }
    }
    
    var isEditable: Bool = false

    // MARK: Private

    private lazy var containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()

    private lazy var titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Asset.separator.color
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private func configureSubviews() {
        contentView.addSubview(containerView)
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = Asset.separator.color.cgColor

        containerView.addSubview(titleView)
        titleView.addSubview(titleLabel)

        containerView.addSubview(containerStack)
    }

    private func makeConstraints() {
        containerView.pinToSuperview(with: .init(top: 16, left: 16, bottom: 0, right: 16))
        titleView.pin(excluding: .bottom)
        containerStack.pin(excluding: .top).top(to: .bottom, of: titleView)
        titleLabel.pinToSuperview(with: .init(top: 16, left: 16, bottom: 16, right: 16))
    }

    private func makeScheduleRow(_ schedule: Schedule? = nil, pairNumber: Int) -> UIView {
        let view = PairView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEditable = isEditable
        view.model = schedule
        view.pairNumber = pairNumber
        view.scheduleEditAction = { [weak self] schedule in
            self?.scheduleEditAction?(schedule)
        }
        return view
    }
}
