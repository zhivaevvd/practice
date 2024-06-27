//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import AutoLayoutSugar
import UIKit

// MARK: - CreateScheduleView

final class CreateScheduleView: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        model = .init()
        super.init(frame: frame)

        configureSubviews()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    var teacherTapAction: ((Teacher?) -> Void)?
    var lessonTapAction: ((Lesson?) -> Void)?
    var groupTapAction: ((Group?) -> Void)?
    var classTapAction: ((Class?) -> Void)?
    var dateTapAction: (() -> Void)?
    var saveAction: ((CreateSchedule) -> Void)?
    var pairNumberAction: ((Int?) -> Void)?
    var deleteAction: ((Int) -> Void)?

    var model: CreateSchedule {
        didSet {
            let teacherName = (model.teacher?.name ?? "") + " " + (model.teacher?.surname ?? "")
            teacherLabel.attributedText = buildTitleAndDescription(L10n.Schedule.teacher, teacherName)
            lessonLabel.attributedText = buildTitleAndDescription(L10n.Schedule.lesson, model.lesson?.name ?? "")
            classLabel.attributedText = buildTitleAndDescription(L10n.Schedule.classroom, model.class?.pickerText ?? "")
            groupLabel.attributedText = buildTitleAndDescription(L10n.Schedule.group, model.group?.name ?? "")

            if let pairNumber = model.pairNumber {
                pairNumberLabel.attributedText = buildTitleAndDescription(L10n.Schedule.pair, String(pairNumber))
            } else {
                pairNumberLabel.attributedText = buildTitleAndDescription(L10n.Schedule.pair, "")
            }

            if let date = model.date {
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "ru_RU")
                formatter.dateFormat = "d MMMM, EEEE"

                let strValue = formatter.string(from: date)
                dateLabel.attributedText = buildTitleAndDescription(L10n.Schedule.date, strValue)
            } else {
                dateLabel.attributedText = buildTitleAndDescription(L10n.Schedule.date, "")
            }
        }
    }

    func setLessonsEnabled(_ enabled: Bool) {
        lessonView.isUserInteractionEnabled = enabled
        lessonView.alpha = enabled ? 1 : 0.5
    }
    
    func setTeacherEnable(_ enabled: Bool) {
        teacherView.isUserInteractionEnabled = enabled
        teacherView.alpha = enabled ? 1 : 0.5
    }
    
    func setDeleteButtonHidden(_ hidden: Bool) {
        deleteButton.isHidden = hidden
    }

    // MARK: Private

    private lazy var teacherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8

        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(teacherTapped))
        view.addGestureRecognizer(tapGestRecognizer)
        return view
    }()

    private lazy var teacherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(
            string: L10n.Schedule.teacher,
            attributes: [.foregroundColor: Asset.navBlue.color.withAlphaComponent(0.8)]
        )
        return label
    }()

    private lazy var lessonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(lessonTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    private lazy var lessonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(
            string: L10n.Schedule.lesson,
            attributes: [.foregroundColor: Asset.navBlue.color.withAlphaComponent(0.8)]
        )
        return label
    }()

    private lazy var classView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(classTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    private lazy var classLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(
            string: L10n.Schedule.classroom,
            attributes: [.foregroundColor: Asset.navBlue.color.withAlphaComponent(0.8)]
        )
        return label
    }()

    private lazy var groupView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(groupTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    private lazy var groupLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(
            string: L10n.Schedule.group,
            attributes: [.foregroundColor: Asset.navBlue.color.withAlphaComponent(0.8)]
        )
        return label
    }()

    private lazy var dateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dateTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(
            string: L10n.Schedule.date,
            attributes: [.foregroundColor: Asset.navBlue.color.withAlphaComponent(0.8)]
        )
        return label
    }()

    private lazy var pairNumberView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pairTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    private lazy var pairNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(
            string: L10n.Schedule.pair,
            attributes: [.foregroundColor: Asset.navBlue.color.withAlphaComponent(0.8)]
        )
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pairTapped))
        label.addGestureRecognizer(tapGesture)
        return label
    }()

    private lazy var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        stack.axis = .vertical
        return stack
    }()

    private lazy var saveButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(L10n.Common.save.uppercased(), for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = Asset.navBlue.color
        btn.titleLabel?.textColor = .white
        btn.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        btn.height(44)
        return btn
    }()
    
    private lazy var deleteButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(L10n.Action.deleteAction.uppercased(), for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .red
        btn.titleLabel?.textColor = .white
        btn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        btn.height(44)
        return btn
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()

    private func configureSubviews() {
        teacherView.addSubview(teacherLabel)
        lessonView.addSubview(lessonLabel)
        groupView.addSubview(groupLabel)
        classView.addSubview(classLabel)
        dateView.addSubview(dateLabel)
        pairNumberView.addSubview(pairNumberLabel)

        containerStack.addArrangedSubviews([teacherView, lessonView, groupView, classView, dateView, pairNumberView])

        addSubview(containerStack)
        buttonsStack.addArrangedSubviews([saveButton, deleteButton])
        addSubview(buttonsStack)

        [teacherView, lessonView, groupView, classView, dateView, pairNumberView].forEach { view in
            view.layer.borderWidth = 2
            view.layer.borderColor = Asset.separator.color.cgColor
        }
    }

    private func makeConstraints() {
        containerStack.pin(excluding: .bottom)
        buttonsStack.left().right().bottom(20)
        buttonsStack.topAnchor.constraint(greaterThanOrEqualTo: containerStack.bottomAnchor, constant: 40).isActive = true

        teacherLabel.pinToSuperview(with: .init(top: 20, left: 20, bottom: 20, right: 20))
        lessonLabel.pinToSuperview(with: .init(top: 20, left: 20, bottom: 20, right: 20))
        groupLabel.pinToSuperview(with: .init(top: 20, left: 20, bottom: 20, right: 20))
        classLabel.pinToSuperview(with: .init(top: 20, left: 20, bottom: 20, right: 20))
        dateLabel.pinToSuperview(with: .init(top: 20, left: 20, bottom: 20, right: 20))
        pairNumberLabel.pinToSuperview(with: .init(top: 20, left: 20, bottom: 20, right: 20))
    }

    private func buildTitleAndDescription(_ title: String, _ description: String) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: title)
        attrString.addAttributes(
            [.foregroundColor: Asset.navBlue.color.withAlphaComponent(0.8)],
            range: NSRange(location: 0, length: attrString.length)
        )
        attrString.append(NSAttributedString(string: description))
        return attrString
    }
}

// MARK: Tap actions functions

private extension CreateScheduleView {
    @objc
    func teacherTapped() {
        teacherTapAction?(model.teacher)
    }

    @objc
    func lessonTapped() {
        lessonTapAction?(model.lesson)
    }

    @objc
    func groupTapped() {
        groupTapAction?(model.group)
    }

    @objc
    func classTapped() {
        classTapAction?(model.class)
    }

    @objc
    func dateTapped() {
        dateTapAction?()
    }

    @objc
    func saveTapped() {
        saveAction?(model)
    }

    @objc
    func pairTapped() {
        pairNumberAction?(model.pairNumber)
    }
    
    @objc
    func deleteTapped() {
        guard let id = model.scheduleId else { return }
        deleteAction?(id)
    }
}
