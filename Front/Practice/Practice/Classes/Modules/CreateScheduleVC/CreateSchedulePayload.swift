//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

struct CreateSchedulePayload {
    var teacher: Teacher?
    var lesson: Lesson?
    var `class`: Class?
    var group: Group?
    var date: Date?
    var pairNumber: Int?

    func validate() -> Bool {
        teacher != nil &&
            lesson != nil &&
            `class` != nil &&
            group != nil &&
            date != nil &&
            pairNumber != nil
    }

    mutating func reset() {
        teacher = nil
        lesson = nil
        `class` = nil
        group = nil
        date = nil
    }
}
