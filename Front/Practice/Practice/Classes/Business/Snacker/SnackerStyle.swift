//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import UIKit

struct SnackStyle {
    // MARK: Lifecycle

    init(textColor: UIColor, backgroundColor: UIColor, font: UIFont) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.font = font
    }

    // MARK: Internal

    static let error = SnackStyle(textColor: .white, backgroundColor: .red, font: .systemFont(ofSize: 14))

    var textColor: UIColor
    var backgroundColor: UIColor
    var font: UIFont
}
