import TISwiftUtils
import UIKit
import TIUIKitCore
import TIAuth

final class ProjectCodeConfirmPresenter: DefaultCodeConfirmPresenter<ApiResponse<TokensResponse>,
                                                                        ApiResponse<SMSSendResponse>>,
                                            UIViewControllerPresenter,
                                            CodeConfirmStateStorage {

    // MARK: - CodeConfirmStateStorage

    var currentUserInput: String? {
        didSet {
            if currentUserInput == nil {
                view?.clearCodeInput()
            }
        }
    }

    var canRefreshCodeAfter: Int? {
        didSet {
            if let secondsLeft = canRefreshCodeAfter {
                view?.set(codeLifetimeText: "You can request new code after \(secondsLeft) seconds")
            } else {
                view?.set(codeLifetimeText: "")
            }
        }
    }

    var remainingAttempts: Int?

    var isExecutingRequest: Bool = false {
        didSet {
            view?.set(isExecutingRequest: isExecutingRequest)
        }
    }

    var canRequestNewCode: Bool = false {
        didSet {
            view?.set(requestNewCodeButtonEnabled: canRequestNewCode)
        }
    }

    private weak var view: CodeConfirmView?
    private var uikitEventHandler: UIKitEventHandler?
    private let phone: String

    init(input: PhoneLoginPresenter.ModuleResult, authService: AuthService, output: Output) {
        self.phone = input.phone

        let confirmRequest: Requests.ConfirmRequestClosure = {
            await authService.smsConfirm(confirmData: .init(phone: input.phone,
                                                      smsCode: $0))
                .mapError { $0.map { $0.errorResponse } }
        }

        let refreshRequest: Requests.RefreshRequestClosure = {
            await authService.authorization(credentials: .init(phone: input.phone))
                .mapError { $0.map { $0.errorResponse } }
        }

        super.init(input: input.smsSendResponse,
                   output: output,
                   requests: .init(confirmRequest: confirmRequest, refreshRequest: refreshRequest))

        self.stateStorage = self

        self.uikitEventHandler = .init(requestNewCodeClosure: { [weak self] in
            self?.refreshCode()
        },
                                       inputUpdatedClosure: { [weak self] in
            self?.inputChanged(newInput: $0)
        })

        self.config.codeLength = 4
    }

    override func isSuccessConfirm(response: ApiResponse<TokensResponse>) -> Bool {
        if case .success = response {
            return true
        }

        return false
    }

    override func isSuccessRefresh(response: ApiResponse<SMSSendResponse>) -> Bool {
        if case .success = response {
            return true
        }

        return false
    }

    override func viewDidPresented() {
        super.viewDidPresented()

        view?.addTarget(uikitEventHandler, requestCodeTappedAction: #selector(UIKitEventHandler.resendCodeRequested))
        view?.configure(phone: phone, textFieldDelegate: uikitEventHandler)
        view?.becomeFirstResponder()
    }

    // MARK: - UIViewControllerPresenter

    func createViewController() -> CodeConfirmViewController {
        let viewController = CodeConfirmViewController(viewModel: self)

        view = viewController.customView

        return viewController
    }
}

private final class UIKitEventHandler: NSObject, UITextFieldDelegate {
    typealias RequestNewCodeClosure = VoidClosure
    typealias InputUpdatedClosure = ParameterClosure<String?>

    let requestNewCodeClosure: RequestNewCodeClosure
    let inputUpdatedClosure: InputUpdatedClosure

    init(requestNewCodeClosure: @escaping RequestNewCodeClosure,
         inputUpdatedClosure: @escaping InputUpdatedClosure) {

        self.requestNewCodeClosure = requestNewCodeClosure
        self.inputUpdatedClosure = inputUpdatedClosure
    }

    // MARK: - UITextFieldDelegate

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        let updatedText: String?

        if let text = textField.text, let textRange = Range(range, in: text) {
            updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
        } else {
            updatedText = nil
        }

        DispatchQueue.main.async { // complete text field state update
            self.inputUpdatedClosure(updatedText)
        }

        return true
    }

    // MARK: - Actions

    @objc func resendCodeRequested() {
        requestNewCodeClosure()
    }
}
