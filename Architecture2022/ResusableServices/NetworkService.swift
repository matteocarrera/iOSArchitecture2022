import Foundation

final class NetworkService: ExternalService {
    typealias ErrorType = APIError

    enum APIError: Error {
        case tokenExpired
    }

    init() {
        debugPrint("network service created")
    }
    
    func auth(login: String, password: String) async throws -> LoginResponse {
        if password == "qwerty" {
            return LoginResponse(accessToken: "access",
                                 refreshToken: "refresh",
                                 profile: Profile(login: login))
        } else {
            throw APIError.tokenExpired
        }
    }

    func renewToken(body: RefreshTokenBody) async throws -> LoginResponse {
        LoginResponse(accessToken: "access new",
                      refreshToken: "refresh new",
                      profile: Profile(login: "refreshed"))
    }
}
