

import Foundation

enum UserRequest: Request {
    case login(user: String, password: String)
    case getProfile(id: Int)

    // MARK: Internal

    var path: String {
        switch self {
        case let .login(user: user, password: password):
            return "login/\(user)&\(password)"
        case let .getProfile(id: id):
            return "person/\(id)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .login:
            return .get
        case .getProfile:
            return .get
        }
    }

    var body: Data? {
        nil
    }

    var mock: Data? {
        switch self {
        case .getProfile:
            guard let path = Bundle.main.path(forResource: "getProfile", ofType: "json"),
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
