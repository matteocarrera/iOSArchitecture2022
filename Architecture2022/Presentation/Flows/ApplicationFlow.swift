import UIKit

final class ApplicationFlow {

    @Weaver(.reference)
    private var authFlow: AuthFlow

    @Weaver(.reference)
    private var pickupFlow: PickupFlow

    @Weaver(.reference)
    private var errorHandlingRegistrationService: ErrorHandlingRegistrationService

    private var window: UIWindow?

    private var rootNavigation: UINavigationController?

    init(injecting _: ApplicationFlowDependencyResolver) {
        //
    }

    func start(on window: UIWindow) {
        self.window = window

        let navigationController = UINavigationController()
        rootNavigation = navigationController

        window.setRootViewController(rootNavigation, animated: true)
        window.makeKeyAndVisible()

        errorHandlingRegistrationService.registerUIHandlers(alertHostViewController: navigationController)

        pickupFlow.start(on: navigationController)

//        authFlow.start(on: navigationController) { [weak self] in
//            self?.startMainFlow(with: $0)
//        }
    }

    private func startMainFlow(with profile: ProfileResponse) {
        let mainController = UIViewController()
        rootNavigation?.setViewControllers([mainController], animated: true)
    }
}
