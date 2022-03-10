import SwiftUI
import TISwiftUtils

final class AuthFlow {

    typealias ResultCompletion = ParameterClosure<ProfileResponse>

    @Weaver(.reference)
    private var authService: AuthService

    @Weaver(.reference)
    private var userProfileService: UserProfileService

    init(injecting: AuthFlowDependencyResolver) {
        //
    }

    func start(on rootNavigation: UINavigationController, completion: @escaping ResultCompletion) {
        if authService.isLoggedIn, let userProfile = userProfileService.currentProfile {
            debugPrint("Open main flow")

            completion(userProfile)
        } else {
            debugPrint("Open auth flow")

            let loginView = LoginView(presenter: .init(userProfileService: userProfileService),
                                      output: .init(onLogin: { [weak self] in
                self?.startLogin(with: $0, navigation: rootNavigation, completion: completion)
            }))

            rootNavigation.pushViewController(UIHostingController(rootView: loginView), animated: false)
        }
    }

    private func startLogin(with credentials: LoginPasswordRequestBody,
                            navigation: UINavigationController,
                            completion: @escaping ResultCompletion) {

        Task {
            let loginResponse = await authService.authorization(login: credentials.login,
                                                                password: credentials.password)

            if case .success = loginResponse, let profile = try? await userProfileService.profile().get() {
                debugPrint("Success auth with profile \(profile.name)")
                DispatchQueue.main.async {
                    completion(profile)
                }
            } else {
                debugPrint("Auth failed")
            }
        }
    }

    private func startCodeConfirm(navigation: UINavigationController, completion: @escaping VoidClosure) {
        let codeConfirmViewController = CodeConfirmViewController(viewModel: CodeConfirmPresenter())
        codeConfirmViewController.output = .init(onCodeConfirm: {
            completion()
        })

        navigation.pushViewController(codeConfirmViewController, animated: true)
    }
}
