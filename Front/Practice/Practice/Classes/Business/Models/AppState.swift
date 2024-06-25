
import Foundation

struct AppState {
    var accessToken: String?

    var isUserAuthenticated: Bool {
        !(accessToken ?? "").isEmpty
    }

    var userId: String?

    var user: Profile?
}
