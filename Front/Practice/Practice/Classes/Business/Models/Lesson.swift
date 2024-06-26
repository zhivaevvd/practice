//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

struct Lesson: Decodable, Pickerable {
    let id: Int
    let name: String

    var pickerText: String {
        name
    }
}
