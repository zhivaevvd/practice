//
//  Schedule.swift
//  Practice
//
//  Created by Влад Живаев on 25.06.2024.
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
