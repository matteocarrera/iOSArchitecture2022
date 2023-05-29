import SwiftUI
import TISwiftUtils
import TIAuth

@MainActor
final class AuthFlow {

    typealias ResultCompletion = VoidClosure

    @Weaver(.reference)
    private var authService: AuthService

    @Weaver(.reference)
    private var userProfileService: UserProfileService

    nonisolated init(injecting: AuthFlowDependencyResolver) {
        //
    }

    func start(on rootNavigation: UINavigationController, completion: @escaping ResultCompletion) {
        if authService.isLoggedIn {
            debugPrint("Open main flow")

            completion()
        } else {
            debugPrint("Open auth flow")

            startPhoneLogin(on: rootNavigation, completion: completion)
        }
    }

    private func startPhoneLogin(on rootNavigation: UINavigationController,
                                 completion: @escaping ResultCompletion) {
        let presenter = PhoneLoginPresenter(authService: authService,
                                            output: .init(otpRequested: { [weak self] in
            self?.startCodeConfirm(navigation: rootNavigation,
                                   phoneLoginResult: $0,
                                   completion: completion)
        }))

        rootNavigation.pushViewController(UIHostingController(rootView: presenter.createView()), animated: false)
    }

    private func startCodeConfirm(navigation: UINavigationController,
                                  phoneLoginResult: PhoneLoginPresenter.ModuleResult,
                                  completion: @escaping VoidClosure) {

        let codeConfirmViewController = ProjectCodeConfirmPresenter(input: phoneLoginResult,
                                                                       authService: authService,
                                                                       output: .init(onConfirmSuccess: { _ in
            completion()
        }))
        .createViewController()

        navigation.pushViewController(codeConfirmViewController, animated: true)
    }
}
