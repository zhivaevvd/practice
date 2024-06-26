//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

struct Group: Decodable, Hashable, Pickerable {
    let id: Int
    let number: String

    var pickerText: String {
        number
    }
}
