import TIUIElements
import UIKit

final class CodeConfirmView: BaseInitializableView {
    private let codeTextView = UITextField()

    var code: String? {
        get {
            codeTextView.text
        }
        set {
            codeTextView.text = newValue
        }
    }
}
