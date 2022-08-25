import TINetworking
import TIFoundationUtils
import Moya

final class RefreshTokenService: EndpointResponseTokenInterceptor<ErrorResponse, MoyaError> {

    @Weaver(.reference)
    var authService: AuthService

    init(injecting: RefreshTokenServiceDependencyResolver) {
        super.init { [authService = injecting.authService] _, _, _ in
            authService.tokenStorage.isAccessTokenValid
        } refreshTokenClosure: { [authService = injecting.authService] errorCompletion in
            _Concurrency.Task {
                switch await authService.refreshToken() {
                case .success:
                    errorCompletion(nil)
                case let .failure(errorResponse):
                    errorCompletion(errorResponse)
                }
            }
        } isTokenInvalidErrorResultClosure: { endpointErrorResult in
            guard case let .apiError(apiError) = endpointErrorResult else {
                return false
            }

            switch apiError.errorCode {
            case .invalidJwtToken,
                 .incorrectJwtTokenGiven:
                return true
            default:
                return false
            }
        }
    }
}
