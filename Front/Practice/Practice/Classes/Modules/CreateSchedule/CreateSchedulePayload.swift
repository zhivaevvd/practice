//
//  CreateSchedulePayload.swift
//  Practice
//
//  Created by Влад Живаев on 27.06.2024.
//

import Foundation

struct CreateSchedulePayload: Encodable {
    init(teacherId: Int, classId: Int, groupId: Int, lessonId: Int, date: Date, pairNumber: Int) {
        self.teacherId = teacherId
        self.classId = classId
        self.groupId = groupId
        self.lessonId = lessonId
        self.date = date
        self.pairNumber = pairNumber
    }
    
    let teacherId: Int
    let classId: Int
    let groupId: Int
    let lessonId: Int
    let date: Date
    let pairNumber: Int
}
