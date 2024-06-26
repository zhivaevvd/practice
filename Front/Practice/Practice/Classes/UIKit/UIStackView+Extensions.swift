//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import UIKit

public extension UIStackView {
    @inlinable
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            addArrangedSubview($0)
        }
    }

    @inlinable
    func removeArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            $0.removeFromSuperview()
        }
    }

    @inlinable
    func removeAllArrangedSubviews() {
        removeArrangedSubviews(arrangedSubviews)
    }
}
