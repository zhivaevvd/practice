//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

struct AppState {
    var accessToken: String?

    var userId: String?

    var user: Profile?

    var isUserAuthenticated: Bool {
        !(accessToken ?? "").isEmpty
    }
}
