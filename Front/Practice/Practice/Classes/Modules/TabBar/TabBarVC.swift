
import UIKit

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        guard dataService?.appState.user?.type == .student, var controllers = self.viewControllers else {
            return
        }
        
        controllers.remove(at: 1)
        self.viewControllers = controllers
    }
    
    var dataService: DataService?
}
