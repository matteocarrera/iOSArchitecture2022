import TIUIElements
import UIKit
import SnapKit

final class CodeConfirmView: BaseInitializableView {
    private let phoneLabel = UILabel()
    private let codeTextField = UITextField()
    private let requestNewCodeButton = RoundedStatefulButton(type: .custom)

    override func addViews() {
        super.addViews()

        addSubviews(phoneLabel, codeTextField, requestNewCodeButton)
    }

    override func configureLayout() {
        super.configureLayout()

        phoneLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(64)
        }

        codeTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(phoneLabel.snp.bottom).offset(24)
        }

        requestNewCodeButton.snp.makeConstraints {
            $0.top.equalTo(codeTextField.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        backgroundColor = .white

        codeTextField.keyboardType = .numberPad

        requestNewCodeButton.set(backgroundColors: [
            .normal: .blue,
            .disabled: .clear
        ])

        requestNewCodeButton.set(titleColors: [
            .normal: .white,
            .disabled: .darkGray
        ])

        requestNewCodeButton.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                            left: 16,
                                                            bottom: 0,
                                                            right: 16)
    }

    override func localize() {
        super.localize()

        requestNewCodeButton.setTitle("Request new code", for: .normal)
    }

    // MARK: - Configuration

    func configure(phone: String, textFieldDelegate: UITextFieldDelegate?) {
        phoneLabel.text = phone
        codeTextField.delegate = textFieldDelegate
    }

    // MARK: - UIView subclass

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        codeTextField.becomeFirstResponder()
    }

    @discardableResult
    override func resignFirstResponder() -> Bool {
        codeTextField.resignFirstResponder()
    }

    // MARK: - Actions

    func addTarget(_ target: Any?, requestCodeTappedAction: Selector) {
        requestNewCodeButton.addTarget(target,
                                       action: requestCodeTappedAction,
                                       for: .touchUpInside)
    }

    // MARK: - Presenter methods

    func set(isExecutingRequest: Bool) {
        isUserInteractionEnabled = !isExecutingRequest
        let wasEnabled = requestNewCodeButton.isEnabled
        requestNewCodeButton.isLoading = isExecutingRequest
        requestNewCodeButton.isEnabled = wasEnabled
    }

    func set(codeLifetimeText newText: String) {
        requestNewCodeButton.isEnabled = false
        requestNewCodeButton.setTitle(newText, for: .disabled)
    }

    func set(requestNewCodeButtonEnabled: Bool) {
        requestNewCodeButton.isEnabled = requestNewCodeButtonEnabled
    }

    func clearCodeInput() {
        codeTextField.text = nil
    }
}
