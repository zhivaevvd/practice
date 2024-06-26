//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

struct Teacher: Decodable, Hashable, Pickerable {
    let id: Int
    let name: String
    let surname: String

    var pickerText: String {
        name + " " + surname
    }
}
