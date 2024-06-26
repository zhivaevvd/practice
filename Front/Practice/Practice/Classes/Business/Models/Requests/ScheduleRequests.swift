//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

enum ScheduleRequest: Request {
    case getSchedule(groupId: Int?)
    case getGroups(teacherId: Int?)
    case getTeachers
    case getLessons(teacherId: Int?)
    case classes
    case createSchedule(payload: CreateSchedulePayload)

    // MARK: Internal

    var path: String {
        switch self {
        case let .getSchedule(groupId):
            if let groupId = groupId {
                return "schedules/\(String(groupId))"
            }
            return "schedules"
        case let .getGroups(teacherId):
            if let teacherId = teacherId {
                return "groups/\(teacherId)"
            }
            return "groups"
        case .getTeachers:
            return "teachers"
        case let .getLessons(teacherId):
            if let teacherId = teacherId {
                return "lessons/\(String(teacherId))"
            }
            return "lessons"
        case .classes:
            return "classes"
        case .createSchedule:
            return "schedule/create"
        }
    }

    var method: RequestMethod {
        switch self {
        case .createSchedule:
            return .post
        default:
            return .get
        }
    }

    var mock: Data? {
        switch self {
        case .getSchedule:
            guard let path = Bundle.main.path(forResource: "schedule", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        case .getGroups:
            guard let path = Bundle.main.path(forResource: "groups", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        case .getTeachers:
            guard let path = Bundle.main.path(forResource: "teachers", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        case .getLessons:
            guard let path = Bundle.main.path(forResource: "lessons", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        case .classes:
            guard let path = Bundle.main.path(forResource: "classes", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        case .createSchedule:
            guard let path = Bundle.main.path(forResource: "successResponse", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        }
    }
}
