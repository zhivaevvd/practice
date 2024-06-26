//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import UIKit

extension LoaderParameters {
    static let white = LoaderParameters(
        color: .white,
        diameter: 44.0,
        strokeThickness: 2.0,
        installConstraints: true,
        isBlocker: false
    )

    static let blue = LoaderParameters(
        color: Asset.navBlue.color,
        diameter: 44.0,
        strokeThickness: 2.0,
        installConstraints: true,
        isBlocker: false
    )

    static let smallBlue = LoaderParameters(
        color: Asset.navBlue.color,
        diameter: 20.0,
        strokeThickness: 1.5,
        installConstraints: true,
        isBlocker: false
    )

    static let smallWhite = LoaderParameters(
        color: Asset.navBlue.color,
        diameter: 20.0,
        strokeThickness: 1.5,
        installConstraints: true,
        isBlocker: false
    )
}
