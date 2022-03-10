import UIKit
import KeychainAccess
import LocalAuthentication
import TIFoundationUtils

final class AppDependencies {
    
    private let dependencies = MainDependencyContainer.appDependenciesDependencyResolver()

    @Weaver(.registration, builder: DependencyFactory.makeLocalAuthenticationContext(_:))
    var localAuthenticationContext: LAContext

    @Weaver(.registration, builder: DependencyFactory.makeAppKeychainThisDeviceOnly)
    var appKeychain: Keychain

    @Weaver(.registration)
    var dateFormattersReusePool: DateFormattersReusePool

    @Weaver(.registration)
    var iso8601DateFormattersReusePool: ISO8601DateFormattersReusePool

    @Weaver(.registration)
    var projectJsonCodingConfigurator: ProjectJsonCodingConfigurator

    @Weaver(.registration)
    var tokenStorageService: TokenStorageService

    @Weaver(.registration)
    var projectNetworkService: ProjectNetworkService

    @Weaver(.registration)
    var userProfileService: UserProfileService

    @Weaver(.registration)
    var authService: AuthService

    @Weaver(.registration)
    var projectDateFormattingService: ProjectDateFormattingService

    @Weaver(.registration)
    var refreshTokenService: RefreshTokenService

    @Weaver(.registration)
    var displayAlertService: DisplayAlertService

    @Weaver(.registration)
    var errorHandlingRegistrationService: ErrorHandlingRegistrationService

    @Weaver(.registration)
    var authFlow: AuthFlow

    @Weaver(.registration)
    var applicationFlow: ApplicationFlow

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
