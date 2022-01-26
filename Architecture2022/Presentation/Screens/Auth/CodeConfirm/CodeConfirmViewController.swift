import Foundation
import TIUIKitCore
import TISwiftUtils

final class CodeConfirmViewController: BaseViewController<CodeConfirmView, CodeConfirmPresenter> {

    struct Output {
        let onCodeConfirm: VoidClosure
    }

    var output: Output?

    @objc private func confirmButtonTapped() {
        guard let code = customView.code else {
            return
        }

        viewModel.check(code: code)
    }
}
