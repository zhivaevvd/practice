//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import UIKit

struct LoaderParameters {
    // MARK: Lifecycle

    init(
        color: UIColor,
        diameter: CGFloat,
        strokeThickness: CGFloat,
        installConstraints: Bool = true,
        isBlocker: Bool
    ) {
        self.color = color
        self.diameter = diameter
        self.strokeThickness = strokeThickness
        self.installConstraints = installConstraints
        self.isBlocker = isBlocker
    }

    // MARK: Internal

    static let empty = LoaderParameters(
        color: UIColor.clear,
        diameter: 0.0,
        strokeThickness: 0.0,
        installConstraints: true,
        isBlocker: false
    )

    let color: UIColor
    let diameter: CGFloat
    let strokeThickness: CGFloat
    var installConstraints: Bool = true
    let isBlocker: Bool
}
