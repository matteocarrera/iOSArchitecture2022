import Foundation
import TIFoundationUtils
import TIKeychainUtils
import LocalAuthentication
import KeychainAccess

final class TokenStorageService {
    @Weaver(.reference)
    private var appKeychain: Keychain

    @Weaver(.reference)
    private var jsonCodingConfigurator: ProjectJsonCodingConfigurator

    private let keyValueEncoder: JSONKeyValueEncoder
    private let keyValueDecoder: JSONKeyValueDecoder

    private(set) var accessToken: Token? {
        get {
            try? appKeychain.codableObject(forKey: .accessToken,
                                           decoder: keyValueDecoder)
        }
        set {
            try? appKeychain.setOrRemove(codableObject: newValue,
                                         forKey: .accessToken,
                                         encoder: keyValueEncoder)
        }
    }

    private(set) var refreshToken: Token? {
        get {
            appKeychain[.refreshToken]
        }
        set {
            try? appKeychain.setOrRemove(codableObject: newValue, forKey: .refreshToken)
        }
    }

    init(injecting resolver: TokenStorageServiceDependencyResolver) {
        keyValueEncoder = JSONKeyValueEncoder(jsonEncoder: resolver.jsonCodingConfigurator.jsonEncoder)
        keyValueDecoder = JSONKeyValueDecoder(jsonDecoder: resolver.jsonCodingConfigurator.jsonDecoder)
    }

    func update(tokens: TokensResponse) {
        accessToken = tokens.accessToken
        refreshToken = tokens.refreshToken
    }

    func clear() {
        accessToken = nil
        refreshToken = nil
    }
}
