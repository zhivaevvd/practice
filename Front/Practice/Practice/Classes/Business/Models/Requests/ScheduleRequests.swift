

import Foundation

enum ScheduleRequest: Request {
    case getSchedule(groupId: Int?)

    // MARK: Internal

    var path: String {
        switch self {
        case let .getSchedule(groupId):
            return "schedules/\(String(describing: groupId))"
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
        default:
            return nil
        }
    }
}
