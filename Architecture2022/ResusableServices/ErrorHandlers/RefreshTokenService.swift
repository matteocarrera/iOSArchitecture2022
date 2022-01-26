import Foundation

final class RefreshTokenService: ChainedErrorHandler {

    @Weaver(.reference)
    var authService: AuthService

    init(injecting: RefreshTokenServiceDependencyResolver) {
        //
    }

    func process(_ error: Error) async -> Bool {
        switch error {
        case let apiError as NetworkService.APIError where apiError == .tokenExpired:
            do {
                try await authService.renewToken()
                return true
            } catch {
                return false
            }
        default:
            return false
        }
    }
}
