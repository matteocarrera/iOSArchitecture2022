import KeychainAccess
import Foundation
import TIFoundationUtils

final class PreviewDependencies {
    
    private let dependencies = MainDependencyContainer.previewDependenciesDependencyResolver()

    @Weaver(.registration)
    var dateFormattersReusePool: DateFormattersReusePool

    @Weaver(.registration)
    var jsonCodingService: JsonCodingService

    @Weaver(.registration)
    var networkService: ProjectNetworkService

    @Weaver(.registration, builder: DependencyFactory.makeAppKeychainThisDeviceOnly)
    var appKeychain: Keychain

    @Weaver(.registration)
    var tokenStorageService: TokenStorageService

    @Weaver(.registration)
    var userProfileService: UserProfileService
}
