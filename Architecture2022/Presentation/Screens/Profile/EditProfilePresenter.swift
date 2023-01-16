import Foundation
import TISwiftUICore

final class EditProfilePresenter: SwiftUIPresenter {

    private let userProfile: ProfileResponse

    var userName: String {
        userProfile.name
    }

    init(userProfile: ProfileResponse) {
        self.userProfile = userProfile
    }

    func createView() -> EditProfileView {
        EditProfileView(presenter: self)
    }

    static func assembleForPreview() -> Self {
        .init(userProfile: .init(name: "some name"))
    }
}
