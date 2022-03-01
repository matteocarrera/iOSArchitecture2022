import Foundation
import TIMoyaNetworking

final class RefreshTokenService: AsyncErrorHandler {

    @Weaver(.reference)
    var authService: AuthService

    init(injecting: RefreshTokenServiceDependencyResolver) {
        //
    }

    func handle(_ error: ErrorResponse) async -> Bool {
        switch error.errorCode {
        case .invalidJwtToken,
             .incorrectJwtTokenGiven:

            switch await authService.refreshToken() {
            case .success:
                return true
            case .failure:
                return false
            }
        default:
            return false
        }
    }
}
