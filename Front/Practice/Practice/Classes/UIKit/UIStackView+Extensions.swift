//
//  UIStackView+Extensions.swift
//  Practice
//
//  Created by Влад Живаев on 25.06.2024.
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
