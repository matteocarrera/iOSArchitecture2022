import UIKit

final class ApplicationFlow {

    @Weaver(.reference)
    private var authFlow: AuthFlow

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

        authFlow.start(on: navigationController) { [weak self] in
            self?.startMainFlow(with: $0)
        }
    }

    private func startMainFlow(with profile: Profile) {
        let mainController = UIViewController()
        rootNavigation?.setViewControllers([mainController], animated: true)
    }
}
