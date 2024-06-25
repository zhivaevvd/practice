
import Foundation

struct ProfileType: Codable, RawRepresentable, Hashable, Equatable {
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    static let admin: ProfileType = .init(rawValue: "admin")
    static let student: ProfileType = .init(rawValue: "student")
    static let teacher: ProfileType = .init(rawValue: "teacher")
    
    let rawValue: String
}

struct Profile: Codable, Hashable, Equatable {
    let id: Int
    let authId: Int
    let name: String
    let surname: String
    let type: ProfileType
    let avatarUrl: String?
    let groupId: Int?
}

extension Profile {
    var readableType: String {
        switch type {
        case .admin:
            return "Администратор"
        case .student:
            return "Студент"
        case .teacher:
            return "Преподаватель"
        default:
            return ""
        }
    }
}
