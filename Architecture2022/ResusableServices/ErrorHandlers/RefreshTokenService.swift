import Foundation
import TIMoyaNetworking
import TIFoundationUtils

final class RefreshTokenService: AsyncErrorHandler {

    @Weaver(.reference)
    var authService: AuthService

    private let queue: OperationQueue

    init(injecting: RefreshTokenServiceDependencyResolver) {
        queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
    }

    func handle(_ error: EndpointErrorResult<ErrorResponse>) async -> Bool {
        let oldAccessToken = authService.tokenStorage.accessToken

        guard case let .apiError(apiError) = error else {
            return false
        }

        switch apiError.errorCode {
        case .invalidJwtToken,
             .incorrectJwtTokenGiven:

            return await withCheckedContinuation { continuation in
                ClosureAsyncOperation { [authService] () async -> Bool in
                    guard oldAccessToken != authService.tokenStorage.accessToken else {
                        return (try? await authService.refreshToken().get()) != nil
                    }

                    return true
                }
                .observe(onSuccess: {
                    continuation.resume(returning: $0)
                },
                         callbackQueue: .global(qos: .userInitiated))
                .add(to: queue)
            }
        default:
            return false
        }
    }
}
