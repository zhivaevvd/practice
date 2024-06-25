
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

        //let initialVC: UIViewController? = dataService.appState.isUserAuthenticated ? VCFactory.buildTabBarVC() : VCFactory.buildAuthVC()
        
        var initialVC: UIViewController?
        if dataService.appState.isUserAuthenticated {
            requestProfile()
            initialVC = VCFactory.buildTabBarVC()
        } else {
            initialVC = VCFactory.buildAuthVC()
        }
    
        requestProfile()
        
        window?.rootViewController = VCFactory.buildTabBarVC()
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
