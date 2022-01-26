import SwiftUI
import TISwiftUtils

final class AuthFlow {

    typealias ResultCompletion = ParameterClosure<Profile>

    @Weaver(.reference)
    private var authService: AuthService

    @Weaver(.reference)
    private var errorHandlingService: GlobalErrorHandlingService

    init(injecting: AuthFlowDependencyResolver) {
        //
    }

    func start(on rootNavigation: UINavigationController, completion: @escaping ResultCompletion) {
        if authService.isLoggedIn, let userProfile = authService.currentProfile {
            debugPrint("Open main flow")

            completion(userProfile)
        } else {
            debugPrint("Open auth flow")

            let loginView = LoginView(presenter: .init(authService: authService),
                                      output: .init(onLogin: { [weak self] in
                self?.startLogin(with: $0, navigation: rootNavigation, completion: completion)
            }))

            rootNavigation.pushViewController(UIHostingController(rootView: loginView), animated: false)
        }
    }

    private func startLogin(with credentials: LoginCredentials,
                            navigation: UINavigationController,
                            completion: @escaping ResultCompletion) {

        startCodeConfirm(navigation: navigation, completion: { [authService, errorHandlingService] in
            Task {
                do {
                    let profile = try await authService.auth(login: credentials.login,
                                                             password: credentials.password)
                    debugPrint("Success auth with profile \(profile.login)")
                    completion(profile)
                } catch {
                    debugPrint("Auth failed")
                    _ = await errorHandlingService.process(error)
                }
            }
        })
    }

    private func startCodeConfirm(navigation: UINavigationController, completion: @escaping VoidClosure) {
        let codeConfirmViewController = CodeConfirmViewController(viewModel: CodeConfirmPresenter())
        codeConfirmViewController.output = .init(onCodeConfirm: {
            completion()
        })

        navigation.pushViewController(codeConfirmViewController, animated: true)
    }
}
