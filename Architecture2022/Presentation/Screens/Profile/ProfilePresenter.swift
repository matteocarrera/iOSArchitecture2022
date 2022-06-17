import TISwiftUICore
import Combine

final class ProfilePresenter: SwiftUIPresenter {
    enum State<Content, Error> {
        case inital
        case loading
        case content(Content)
        case error(Error)

        var isLoading: Bool {
            if case .loading = self {
                return true
            }

            return false
        }

        var content: Content? {
            if case let .content(content) = self {
                return content
            }

            return nil
        }
    }
    private let userProfileService: UserProfileService

    @Published private(set) var state: State<ProfileResponse, ErrorResponse> = .inital

    init(userProfileService: UserProfileService) {
        self.userProfileService = userProfileService

        Task {
            state = .loading
            
            switch await userProfileService.profile() {
            case let .success(profileResponse):
                state = .content(profileResponse)
            case let .failure(errorResponse):
                state = .error(errorResponse.firstOr(.default))
            }
        }
    }

    func createView() -> ProfileView {
        ProfileView(presenter: self)
    }

    static func assembleForPreview() -> Self {
        .init(userProfileService: PreviewDependencies().userProfileService)
    }
}
