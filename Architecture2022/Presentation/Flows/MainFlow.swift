import TIDeeplink
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

    private func openDetailsView(completion: (() -> Void)? = nil) {
        guard let currentProfile = userProfileService.currentProfile else {
            return
        }
        let detailsView = DetailsPresenter(userProfile: currentProfile).createView()
        let detailsViewController = UIHostingController(rootView: detailsView)
        rootNavigationController?
            .topVisibleViewController
            .present(detailsViewController, animated: true, completion: completion)
    }

    private func openEditingView() {
        guard let currentProfile = userProfileService.currentProfile else {
            return
        }
        let editView = EditProfilePresenter(userProfile: currentProfile).createView()
        let editViewController = UIHostingController(rootView: editView)
        rootNavigationController?
            .topVisibleViewController
            .present(editViewController, animated: true)
    }
}

// MARK: - DeeplinkHandler

extension MainFlow: DeeplinkHandler {
    func canHandle(deeplink: DeeplinkType) -> Bool {
        guard let _ = deeplink as? AppDeeplink else {
            return false
        }

        return true
    }

    func handle(deeplink: DeeplinkType) -> Operation? {
        guard let deeplink = deeplink as? AppDeeplink else {
            return nil
        }

        switch deeplink {
        case .profileDetails:
            return BlockOperation { [weak self] in
                self?.openDetailsView()
            }
        case .editProfile:
            return BlockOperation { [weak self] in
                self?.openDetailsView {
                    self?.openEditingView()
                }
            }
        }
    }
}
