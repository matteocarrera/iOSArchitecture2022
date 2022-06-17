import TIUIKitCore
import UIKit

final class CodeConfirmViewController: BaseViewController<CodeConfirmView, ProjectCodeConfirmPresenter> {
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidPresented()
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        customView.becomeFirstResponder()
    }
}
