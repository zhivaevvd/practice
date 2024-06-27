//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class PairView: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal
    
    var scheduleEditAction: ((Schedule) -> Void)?

    var model: Schedule? {
        didSet {
            guard let model else {
                editImageView.isHidden = true
                return
            }
            editImageView.isHidden = !isEditable
            nameLabel.attributedText = buildTitleAndDescription(L10n.Schedule.lesson, model.lessonName)
            teacherLabel.attributedText = buildTitleAndDescription(L10n.Schedule.teacher, model.teacher.name + " " + model.teacher.surname)
            classLabel.attributedText = buildTitleAndDescription(L10n.Schedule.classroom, model.class.number)
        }
    }

    var pairNumber: Int? {
        didSet {
            guard let pairNumber else { return }
            pairNumberLabel.text = "\(String(pairNumber))."
        }
    }
    
    var isEditable: Bool = false

    // MARK: Private

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var teacherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var classLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var pairNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var pairNumberView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var pairView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var editImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "pencil.circle")
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    private func configureSubviews() {
        pairNumberView.addSubview(pairNumberLabel)

        pairView.addSubview(nameLabel)
        pairView.addSubview(teacherLabel)
        pairView.addSubview(classLabel)
        pairView.addSubview(editImageView)

        pairView.layer.borderWidth = 1
        pairView.layer.borderColor = Asset.separator.color.cgColor
        pairNumberView.layer.borderWidth = 1
        pairNumberView.layer.borderColor = Asset.separator.color.cgColor

        addSubview(pairNumberView)
        addSubview(pairView)
    }

    private func makeConstraints() {
        pairNumberLabel.top(8).left(16).right(8).bottom(8)

        nameLabel.top(8).left(16).right(16)
        teacherLabel.top(to: .bottom(8), of: nameLabel).left(16).right(to: .left(8), of: editImageView)
        classLabel.top(to: .bottom(8), of: teacherLabel).left(16).right(to: .left(8), of: editImageView).bottom(8)
        editImageView.centerY().right(16).width(20)

        pairNumberView.pin(excluding: .right)
        pairView.pin(excluding: .left).left(to: .right, of: pairNumberView)

        pairView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (48 + 32)).isActive = true
    }

    private func buildTitleAndDescription(_ title: String, _ description: String) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: title)
        attrString.addAttributes([.foregroundColor: Asset.navBlue.color], range: NSRange(location: 0, length: attrString.length))
        attrString.append(NSAttributedString(string: description))
        return attrString
    }
    
    @objc
    private func editTapped() {
        guard let model = model else { return }
        scheduleEditAction?(model)
    }
}
