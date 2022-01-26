import UIKit

struct GlobalErrorHandlingService: ChainedErrorHandler {
    private let chain: Chain<AnyChainedHandler<Error>>

    @Weaver(.reference)
    private var refreshTokenService: RefreshTokenService

    @Weaver(.reference)
    private var alertHostViewController: UIViewController

    init(injecting: GlobalErrorHandlingServiceDependencyResolver) {
        chain = .init(handlers: [
            injecting.refreshTokenService.asAnyChainedHandler(),
            DisplayAlertService(hostViewController: injecting.alertHostViewController).asAnyChainedHandler()
        ])
    }

    func process(_ event: Error) async -> Bool {
        await chain.process(event)
    }
}
