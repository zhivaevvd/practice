

import Foundation

enum ScheduleRequest: Request {
    case getSchedule(groupId: Int?)
    case getGroups(teacherId: Int?)

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
        }
    }

    var method: RequestMethod {
        .get
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
        }
    }
}
