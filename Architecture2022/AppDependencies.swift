import UIKit
final class AppDependencies {
    
    private let dependencies = MainDependencyContainer.appDependenciesDependencyResolver()

    @Weaver(.registration)
    var networkService: NetworkService

    @Weaver(.registration)
    var authService: AuthService

    @Weaver(.registration)
    var refreshTokenService: RefreshTokenService

    @Weaver(.registration, builder: AppDependencies.makeAlertHostViewController)
    var alertHostViewController: UIViewController

    @Weaver(.registration)
    var globalErrorHandlingService: GlobalErrorHandlingService

    @Weaver(.registration)
    var authFlow: AuthFlow

    @Weaver(.registration)
    var applicationFlow: ApplicationFlow

    static func makeAlertHostViewController(_ resolver: AlertHostViewControllerResolver) -> UIViewController {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        let rootViewController = sceneDelegate.window?.rootViewController

        guard let topViewController = rootViewController?.topVisibleViewController else {
            assertionFailure("Unable to find top view controller of the app")
            return UIViewController()
        }

        return topViewController
    }
}

extension UIViewController {

    /// Return top visible controller even if we have inner UI(Navigation/TabBar)Controller's inside
    var topVisibleViewController: UIViewController {
        switch self {
        case let navController as UINavigationController:
            return navController.visibleViewController?.topVisibleViewController ?? navController

        case let tabController as UITabBarController:
            return tabController.selectedViewController?.topVisibleViewController ?? tabController

        default:
            return self.presentedViewController?.topVisibleViewController ?? self
        }
    }
}
