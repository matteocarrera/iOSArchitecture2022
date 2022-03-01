import TIFoundationUtils
import TINetworking

final class UserProfileService {
    @Weaver(.reference)
    private var networkService: ProjectNetworkService

    @Weaver(.reference)
    private var tokenStorageService: TokenStorageService

    @UserDefaultsCodableBackingStore(key: .profile,
                                     codableKeyValueStorage: .standard)
    private(set) var currentProfile: Profile?

    init(injecting _: UserProfileServiceDependencyResolver) {
        //
    }

    func profile() async -> ApiResponse<Profile> {
        let result: ApiResponse<Profile> = await networkService.process(recoverableRequest: ProfileRequestFactory(tokenStorageService: tokenStorageService))

        if case let .success(profile) = result {
            currentProfile = profile
        }

        return result
    }

    func clear() {
        currentProfile = nil
    }
}
