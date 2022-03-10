import KeychainAccess
import Foundation
import TIFoundationUtils

final class PreviewDependencies {
    
    private let dependencies = MainDependencyContainer.previewDependenciesDependencyResolver()

    @Weaver(.registration)
    var dateFormattersReusePool: DateFormattersReusePool

    @Weaver(.registration)
    var iso8601DateFormattersReusePool: ISO8601DateFormattersReusePool

    @Weaver(.registration)
    var projectJsonCodingConfigurator: ProjectJsonCodingConfigurator

    @Weaver(.registration)
    var tokenStorageService: TokenStorageService

    @Weaver(.registration)
    var networkService: ProjectNetworkService

    @Weaver(.registration, builder: DependencyFactory.makeAppKeychainThisDeviceOnly)
    var appKeychain: Keychain

    @Weaver(.registration)
    var userProfileService: UserProfileService
}
