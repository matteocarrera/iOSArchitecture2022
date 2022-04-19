import TIFoundationUtils
import TINetworking

final class UserProfileService {
    @Weaver(.reference)
    private var networkService: ProjectNetworkService

    @Weaver(.reference)
    private var tokenStorageService: TokenStorageService

    @UserDefaultsCodableBackingStore(key: .profile,
                                     codableKeyValueStorage: .standard)
    private(set) var currentProfile: ProfileResponse?

    init(injecting _: UserProfileServiceDependencyResolver) {
        //
    }

    func profile() async -> ApiResponse<ProfileResponse> {
        let result = await networkService.process(recoverableRequest: .profileRequest())

        if case let .success(profile) = result {
            currentProfile = profile
        }

        return result.mapError { $0.errorResponse }
    }

    func clear() {
        currentProfile = nil
    }
}
