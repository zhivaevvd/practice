//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        guard dataService?.appState.user?.type == .student, var controllers = viewControllers else {
            return
        }

        controllers.remove(at: 1)
        viewControllers = controllers
    }

    // MARK: Internal

    var dataService: DataService?
}
