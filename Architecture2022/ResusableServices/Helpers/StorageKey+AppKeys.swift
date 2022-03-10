import TIFoundationUtils

extension StorageKey {
    static var profile: StorageKey<ProfileResponse> {
        .init(rawValue: "profile")
    }

    static var accessToken: StorageKey<Token> {
        .init(rawValue: "accessToken")
    }

    static var refreshToken: StorageKey<Token> {
        .init(rawValue: "refreshToken")
    }
}
