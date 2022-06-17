import SwiftUI

@MainActor
final class MainFlow {

    @Weaver(.reference)
    private var userProfileService: UserProfileService

    nonisolated init(injecting _: MainFlowDependencyResolver) {
        //
    }

    func start(on rootNavigation: UINavigationController) {
        let profileView = ProfilePresenter(userProfileService: userProfileService).createView()
        let profileViewController = UIHostingController(rootView: profileView)
        rootNavigation.setViewControllers([profileViewController], animated: true)
    }
}
