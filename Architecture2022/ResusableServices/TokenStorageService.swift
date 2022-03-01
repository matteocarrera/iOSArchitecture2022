import Foundation
import TIFoundationUtils
import TIKeychainUtils
import LocalAuthentication
import KeychainAccess

final class TokenStorageService {
    @Weaver(.reference)
    private var appKeychain: Keychain

    @Weaver(.reference)
    var jsonCodingService: JsonCodingService

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
        keyValueEncoder = JSONKeyValueEncoder(jsonEncoder: resolver.jsonCodingService.jsonEncoder)
        keyValueDecoder = JSONKeyValueDecoder(jsonDecoder: resolver.jsonCodingService.jsonDecoder)
    }

    func update(tokens: TokenResponse) {
        accessToken = tokens.accessToken
        refreshToken = tokens.refreshToken
    }

    func clear() {
        accessToken = nil
        refreshToken = nil
    }
}
