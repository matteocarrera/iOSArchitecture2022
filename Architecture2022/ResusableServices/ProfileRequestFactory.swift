import TINetworking
import TIMoyaNetworking

struct ProfileRequestFactory: RequestFactory {
    let tokenStorageService: TokenStorageService

    func create() -> Result<EndpointRequest<EmptyBody>, ErrorResponse> {
        guard let bearer = tokenStorageService.accessToken?.value else {
            return .failure(ErrorResponse(errorCode: .invalidJwtToken,
                                          message: "Ошибка 😔"))
        }

        return .success(.apiV3MobileProfile(bearerToken: bearer))
    }
}
