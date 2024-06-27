//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class SelectSheet: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerStack)
        containerStack.pinToSuperview()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    var tapAction: ((Pickerable) -> Void)?

    var selected: Pickerable?

    var model: [Pickerable] = [] {
        didSet {
            containerStack.removeAllArrangedSubviews()
            containerStack.addArrangedSubviews(model.map(buildRow(_:)))
        }
    }

    // MARK: Private

    private lazy var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    private func buildRow(_ model: Pickerable) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = model.pickerText

        let imageView = UIImageView(image: Asset.check.image)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        view.addSubview(imageView)

        label.pin(excluding: .right)
        imageView.pin(excluding: .left)

        imageView.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor).isActive = true
        imageView.isHidden = model.id != selected?.id && model.pickerText != selected?.pickerText

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tapGesture)

        return view
    }

    @objc
    private func tapped(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view,
              let label = view.subviews.first(where: { $0 is UILabel }) as? UILabel,
              let text = label.text,
              let pickerable = model.first(where: { $0.pickerText == text })
        else {
            return
        }

        tapAction?(pickerable)
    }
}
