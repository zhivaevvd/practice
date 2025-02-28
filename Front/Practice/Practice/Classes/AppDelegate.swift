//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Internal

    var window: UIWindow?

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        var initialVC: UIViewController?
        if dataService.appState.isUserAuthenticated {
            requestProfile()
            initialVC = VCFactory.buildTabBarVC()
        } else {
            initialVC = VCFactory.buildAuthVC()
        }

        window?.rootViewController = initialVC
        window?.makeKeyAndVisible()
        configureNavigationBar()
        return true
    }

    // MARK: Private

    private let dataService: DataService = CoreFactory.dataService

    private let profileService: ProfileService = CoreFactory.buildProfileService()

    private func requestProfile() {
        profileService.getProfile { [weak self] result in
            switch result {
            case let .success(profile):
                self?.dataService.appState.user = profile
            case .failure:
                break
            }
        }
    }
}
