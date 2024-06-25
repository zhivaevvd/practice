//
//  Schedule.swift
//  Practice
//
//  Created by Влад Живаев on 25.06.2024.
//

import Foundation

public struct Schedule: Decodable, Hashable {
    public let lessonId: Int
    public let lessonName: String
    public let date: Date
    public let teacher: Teacher
    public let group: Group
    public let `class`: Class
    public let scheduleId: Int
    public let pairNumber: Int
}
