//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

enum UserRequest: Request {
    case login(user: String, password: String)
    case getProfile(id: Int)

    // MARK: Internal

    var path: String {
        switch self {
        case let .login(user: user, password: password):
            return "login"
        case let .getProfile(id: id):
            return "person/\(id)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .login:
            return .post
        case .getProfile:
            return .get
        }
    }

    var body: Data? {
        switch self {
        case let .login(user, password):
            let payload = AuthPayload(login: user, password: password)
            return RequestBuilderImpl.encode(payload)
        default:
            return nil
        }
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
