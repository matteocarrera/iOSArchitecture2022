import Moya
import TISwiftUtils
import TINetworking
import Foundation
import TIMoyaNetworking

final class AuthService {
    @Weaver(.reference)
    var networkService: ProjectNetworkService

    @Weaver(.reference)
    var tokenStorage: TokenStorageService

    var isLoggedIn: Bool {
        tokenStorage.accessToken != nil && tokenStorage.refreshToken != nil
    }

    init(injecting _: AuthServiceDependencyResolver) {
        //
    }

    func authorization(login: String,
                       password: String) async -> ApiResponse<TokenResponse> {

        let body = LoginRequestBody(login: login, password: password)
        let request: EndpointRequest = .apiV3MobileAuthLoginPassword(body: body)

        return updateTokens(for: await networkService.process(recoverableRequest: request.staticRequestFactory()))
    }

    func refreshToken() async -> ApiResponse<TokenResponse> {
        guard let refreshToken = tokenStorage.refreshToken else {
            return .failure(.localTokenMissing())
        }

        let body = RenewTokenRequestBody(refreshToken: refreshToken.value)
        let request: EndpointRequest = .apiV3MobileAuthTokensRenew(body: body)

        return updateTokens(for: await networkService.process(request: request))
    }

    private func updateTokens(for result: ApiResponse<TokenResponse>) -> ApiResponse<TokenResponse> {
        if case let .success(tokenResponse) = result {
            tokenStorage.update(tokens: tokenResponse)
        }

        return result
    }
}

private extension ErrorResponse {
    static func localTokenMissing() -> Self {
        .init(errorCode: .sessionNotRenewable, message: "Вы не авторизованы 😔")
    }
}
