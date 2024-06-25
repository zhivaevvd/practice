
import UIKit

enum VCFactory {
    static func buildAuthVC() -> UIViewController? {
        let vc = StoryboardScene.Auth.initialScene.instantiate()
        let authService = CoreFactory.buildAuthService()
        let snacker = CoreFactory.snacker
        vc.setup(with: authService, snacker)
        return vc
    }

    static func buildTabBarVC() -> UIViewController? {
        let tabBarVC = StoryboardScene.TabBar.initialScene.instantiate()
        tabBarVC.viewControllers?.forEach { vc in
            guard let nvc = vc as? UINavigationController, let rootVC = nvc.viewControllers.first else {
                return
            }
            nvc.navigationBar.prefersLargeTitles = true
            switch rootVC {
            case let vc as ProfileVC:
                let dataService = CoreFactory.dataService
                let profileService = CoreFactory.buildProfileService()
                vc.setup(with: profileService, dataService: dataService)
            case let vc as HistoryVC:
                let historyService = CoreFactory.buildHistoryService()
                vc.setup(with: historyService)
            case let vc as ScheduleVC:
                vc.service = CoreFactory.buildScheduleService()
                vc.snacker = CoreFactory.snacker
            default:
                break
            }
        }

        tabBarVC.dataService = CoreFactory.dataService

        return tabBarVC
    }

    static func buildProductVC(with product: Product) -> UIViewController {
        let vc = ProductVC()
        vc.product = product
        return vc
    }

    static func buildOrderVC(with product: Product) -> UIViewController {
        let vc = OrderVC()
        let orderServise = CoreFactory.buildOrderService()
        let snacker = CoreFactory.snacker
        vc.setup(with: orderServise, snacker: snacker)
        vc.product = product
        return vc
    }

    static func buildBottomSheetController(with contentView: UIView, onEveryTapOut: (() -> Void)?) -> UIViewController {
        let parameters = BottomSheetParameters(contentView: contentView, onEveryTapOut: onEveryTapOut)
        let vc = BottomSheetController(arguments: parameters)
        vc.transitioningDelegate = vc
        return vc
    }
}
