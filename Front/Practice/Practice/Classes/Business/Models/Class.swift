//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

struct Class: Decodable, Hashable, Pickerable {
    let id: Int
    let number: Int

    var pickerText: String {
        String(number)
    }
}
