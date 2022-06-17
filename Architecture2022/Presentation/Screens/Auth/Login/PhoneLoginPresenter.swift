import Combine
import SwiftUI
import TISwiftUtils
import TISwiftUICore

final class PhoneLoginPresenter: SwiftUIPresenter {
    struct ModuleResult {
        let phone: String
        let smsSendResponse: SMSSendResponse
    }

    struct Output {
        let otpRequested: ParameterClosure<ModuleResult>
    }

    @Published var dataModel = SMSSendRequestBody(phone: "79876543210")
    @Published private(set) var isExecutingRequest = false
    @Published private(set) var errorResponse: ErrorResponse?

    var isAlertPresentedBinding: Binding<Bool> {
        Binding {
            self.errorResponse != nil
        } set: { isPresenting in
            self.errorResponse = isPresenting ? self.errorResponse : nil
        }
    }

    var isPhoneFieldFocusedBinding: Binding<Bool> {
        Binding {
            self.isExecutingRequest == false
        } set: { _ in
            // ignore
        }
    }

    private let authService: AuthService
    private let output: Output

    init(authService: AuthService, output: Output) {
        self.authService = authService
        self.output = output
    }

    func didTapLogin() {
        isExecutingRequest = true

        Task {
            switch await authService.authorization(credentials: dataModel) {
            case let .success(response):
                output.otpRequested(ModuleResult(phone: dataModel.phone, smsSendResponse: response))
                break
            case let .failure(errorResult):
                self.errorResponse = errorResult.failures.first?.errorResponse
            }

            isExecutingRequest = false
        }
    }

    func createView() -> PhoneLoginView {
        PhoneLoginView(presenter: self)
    }

#if DEBUG
    static func assembleForPreview() -> Self {
        let presenter = Self(authService: PreviewDependencies().authService,
              output: .init(otpRequested: { _ in }))
        presenter.dataModel.phone = "79876543210"

        return presenter
    }
#endif
}
