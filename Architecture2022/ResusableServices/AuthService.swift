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
                       password: String) async -> ApiResponse<TokensResponse> {

        let body = LoginPasswordRequestBody(login: login, password: password)

        return updateTokens(for: await networkService.process(request: .loginPasswordRequest(body: body)))
    }

    func refreshToken() async -> ApiResponse<TokensResponse> {
        guard let refreshToken = tokenStorage.refreshToken else {
            return .failure(.localTokenMissing())
        }

        let body = TokensRenewRequestBody(refreshToken: refreshToken.value)
        let request: EndpointRequest = .tokenRenewRequest(body: body)

        return updateTokens(for: await networkService.process(request: request))
    }

    private func updateTokens(for result: ApiResponse<TokensResponse>) -> ApiResponse<TokensResponse> {
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
