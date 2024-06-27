//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

enum ScheduleRequest: Request {
    case getSchedule(groupId: Int?)
    case getGroups
    case getTeachers
    case getLessons(teacherId: Int?)
    case classes
    case createSchedule(payload: CreateSchedulePayload)
    case editSchedule(scheduleId: Int, payload: CreateSchedulePayload)
    case deleteSchedule(scheduleId: Int)

    // MARK: Internal

    var path: String {
        switch self {
        case let .getSchedule(groupId):
            if let groupId = groupId {
                return "schedules/\(String(groupId))"
            }
            return "schedules"
        case .getGroups:
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
        case let .editSchedule(scheduleId, _):
            return "schedule/\(scheduleId)"
        case let .deleteSchedule(scheduleId):
            return "schedule/\(scheduleId)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .createSchedule:
            return .post
        case .editSchedule:
            return .put
        case .deleteSchedule:
            return .delete
        default:
            return .get
        }
    }
    
    var body: Data? {
        switch self {
        case let .createSchedule(payload):
            return RequestBuilderImpl.encode(payload)
        case let .editSchedule(_, payload):
            return RequestBuilderImpl.encode(payload)
        default:
            return nil
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
        case .createSchedule, .editSchedule, .deleteSchedule:
            guard let path = Bundle.main.path(forResource: "successResponse", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        }
    }
}
