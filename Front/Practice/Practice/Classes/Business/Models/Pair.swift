//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

struct Pair: Pickerable {
    // MARK: Lifecycle

    init(id: Int) {
        self.id = id
    }

    // MARK: Internal

    let id: Int

    var pickerText: String {
        String(id)
    }
}
