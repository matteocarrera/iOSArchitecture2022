import TISwiftUtils
import TIFoundationUtils
import KeychainAccess

final class AuthService: ExternalService {
    typealias ErrorType = AuthError

    enum AuthError: Error {
        case invalidCredentials
        case missingRefreshToken
    }

    @Weaver(.reference)
    private var networkService: NetworkService

    @UserDefaultsBackingStore(store: .standard,
                              getClosure: { $0.bool(forKey: "isLoggedIn") },
                              setClosure: { $0.set($1, forKey: "isLoggedIn") })
    private(set) var isLoggedIn: Bool

    @BackingStore(store: Keychain.appKeychain(),
                  getClosure: { $0["refreshToken"] },
                  setClosure: { $0["refreshToken"] = $1 })
    private(set) var refreshToken: String?

    @BackingStore(store: Keychain.appKeychain(),
                  getClosure: { $0["accessToken"] },
                  setClosure: { $0["accessToken"] = $1 })
    private(set) var accessToken: String?

    @UserDefaultsCodableBackingStore(key: .profile,
                                     codableKeyValueStorage: .standard)
    private(set) var currentProfile: Profile?

    init(injecting _: AuthServiceDependencyResolver) {
        //
        isLoggedIn = false
    }

    func auth(login: String, password: String) async throws -> Profile {
        let loginResponse = try await networkService.auth(login: login, password: password)
        
        isLoggedIn = true
        currentProfile = loginResponse.profile

        storeTokens(from: loginResponse)
        return loginResponse.profile
    }

    func renewToken() async throws {
        guard let refreshToken = refreshToken else {
            throw AuthError.missingRefreshToken
        }

        let response = try await networkService
            .renewToken(body: RefreshTokenBody(refreshToken: refreshToken))

        storeTokens(from: response)
    }

    private func storeTokens(from response: LoginResponse) {
        accessToken = response.accessToken
        refreshToken = response.refreshToken
    }
}

extension Keychain {
    static func appKeychain() -> Keychain {
        Keychain()
    }
}
