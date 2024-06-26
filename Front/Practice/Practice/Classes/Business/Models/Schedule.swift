//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

struct Schedule: Decodable, Hashable {
    let lessonId: Int
    let lessonName: String
    let date: Date
    let teacher: Teacher
    let group: Group
    let `class`: Class
    let scheduleId: Int
    let pairNumber: Int
}
