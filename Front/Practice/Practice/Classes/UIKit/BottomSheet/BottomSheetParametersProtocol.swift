//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

public protocol BottomSheetParametersProtocol {
    var hasArrow: Bool {
        get
    }
    var shouldDismissOnTapOut: Bool {
        get
    }
    var contentView: ScrollableView {
        get
    }
    var customOnLoadSideEffect: (() -> Void)? {
        get
    }
    var customTapOutAction: (() -> Void)? {
        get
    }

    var onEveryTapOut: (() -> Void)? {
        get
    }
}
