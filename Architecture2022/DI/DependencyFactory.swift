import KeychainAccess
import LocalAuthentication

enum DependencyFactory {
    static func makeAppKeychainThisDeviceOnly(_ resolver: AppKeychainResolver) -> Keychain {
        Keychain(service: "ProjectKeychain")
            .accessibility(.whenUnlockedThisDeviceOnly)
//            .authenticationPrompt(makeLocalAuthenticationContext().biometryType.authenticationPrompt)
            .authenticationContext(makeLocalAuthenticationContext())
    }

    static func makeLocalAuthenticationContext(_ resolver: LocalAuthenticationContextResolver) -> LAContext {
        makeLocalAuthenticationContext()
    }

    private static func makeLocalAuthenticationContext() -> LAContext {
        let context = LAContext()
        context.localizedFallbackTitle = "FALLBACK TITLE"
        context.localizedReason = "LOCALIZED REASON"
        context.localizedCancelTitle = "CANCEL"
        context.touchIDAuthenticationAllowableReuseDuration = 10

        return context
    }
}

private extension LABiometryType {
    var authenticationPrompt: String {
        switch self {
        case .faceID:
            return "PUT YOUR FACE HERE"
        case .touchID:
            return "SHOW YOUR FINGER"
        case .none:
            return "BIOMETRY IS NOT SUPPORTED"
        @unknown default:
            return "UNKNOWN BIOMETRY TYPE"
        }
    }
}
