import UIKit

extension UIWindow {
    func setRootViewController(_ viewController: UIViewController?, animated: Bool = true) {
        rootViewController = viewController

        guard animated else {
            return
        }

        UIView.transition(with: self,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil)
    }
}
