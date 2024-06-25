
import UIKit

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        guard dataService?.appState.user?.type == .student, var controllers = viewControllers else {
            return
        }

        controllers.remove(at: 1)
        viewControllers = controllers
    }

    var dataService: DataService?
}
