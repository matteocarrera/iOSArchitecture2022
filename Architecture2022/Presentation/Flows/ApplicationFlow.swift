import TIDeeplink
import UIKit

@MainActor
final class ApplicationFlow {

    @Weaver(.reference)
    private var authFlow: AuthFlow

    @Weaver(.reference)
    private var pickupFlow: PickupFlow

    @Weaver(.reference)
    private var mainFlow: MainFlow

    @Weaver(.reference)
    private var errorHandlingRegistrationService: ErrorHandlingRegistrationService

    private var window: UIWindow?

    private var rootNavigation: UINavigationController?

    nonisolated init(injecting _: ApplicationFlowDependencyResolver) {
        //
    }

    func start(on window: UIWindow) {
        self.window = window

        TIDeeplinkService.shared.deeplinkHandler = mainFlow
        TIDeeplinksService.shared.deeplinkMapper = AppDeeplinkMapper()

        let navigationController = UINavigationController()
        rootNavigation = navigationController

        window.setRootViewController(rootNavigation, animated: true)
        window.makeKeyAndVisible()

        errorHandlingRegistrationService.registerUIHandlers(alertHostViewController: navigationController)

//        pickupFlow.start(on: navigationController)

        authFlow.start(on: navigationController) { [weak self] in
            self?.mainFlow.start(on: navigationController)
        }
    }
}
