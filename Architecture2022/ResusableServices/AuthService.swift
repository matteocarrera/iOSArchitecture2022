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

    func authorization(credentials: LoginPasswordRequestBody) async -> ProjectNetworkService.EndpointResponse<TokensResponse> {
        updateTokens(for: await networkService.process(request: .loginPasswordRequest(body: credentials))
                            .mapError { .init(failures: [$0]) })
    }

    func authorization(credentials: SMSSendRequestBody) async -> ProjectNetworkService.EndpointResponse<SMSSendResponse> {
        await networkService.process(request: .sMSSendRequest(body: credentials))
            .mapError { .init(failures: [$0]) }
    }

    func smsConfirm(confirmData: LoginSMSRequestBody) async -> ProjectNetworkService.EndpointResponse<TokensResponse> {
        updateTokens(for: await networkService.process(recoverableRequest: .loginSMSRequest(body: confirmData)))
    }

    func codeResend(resendData: ProfileCommunicationRequestBody) async -> ProjectNetworkService.EndpointResponse<ProfileCommunicationResponse> {
        await networkService.process(recoverableRequest: .profileCommunicationRequest(body: resendData))
    }

    func refreshToken() async -> ProjectNetworkService.RequestResult<TokensResponse, ErrorResponse> {
        guard let refreshToken = tokenStorage.refreshToken else {
            return .failure(.apiError(.localTokenMissing()))
        }

        let body = TokensRenewRequestBody(refreshToken: refreshToken.value)
        let request: EndpointRequest = .tokenRenewRequest(body: body)

        return updateTokens(for: await networkService.process(request: request))
    }

    private func updateTokens<F>(for result: Result<TokensResponse, F>) -> Result<TokensResponse, F> {
        if case let .success(tokenResponse) = result {
            tokenStorage.update(tokens: tokenResponse)
        }

        return result
    }
}

private extension ErrorResponse {
    static func localTokenMissing() -> Self {
        .init(errorCode: .sessionNotRenewable, errorMessage: "Вы не авторизованы 😔")
    }
}
