import UIKit

struct ErrorHandlingRegistrationService {
    @Weaver(.reference)
    private var networkService: ProjectNetworkService

    @Weaver(.reference)
    private var displayAlertService: DisplayAlertService

    @Weaver(.registration)
    private var refreshTokenService: RefreshTokenService

    init(injecting _: ErrorHandlingRegistrationServiceDependencyResolver) {
        //
    }

    func registerInvisibleHandlers() {
        // avoid circular dependency problem: RefreshTokenService -> ProjectNetworkService -> RefreshTokenService
        networkService.register(defaultRequestRetrier: refreshTokenService)
    }

    func registerUIHandlers(alertHostViewController: UIViewController) {
        displayAlertService.update(hostViewController: alertHostViewController)
        networkService.register(defaultRequestRetrier: displayAlertService)
    }

    func updateAlertHostController(alertHostViewController: UIViewController) {
        displayAlertService.update(hostViewController: alertHostViewController)
    }
}
