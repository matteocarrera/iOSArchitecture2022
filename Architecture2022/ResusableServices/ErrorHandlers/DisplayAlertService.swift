import UIKit

final class DisplayAlertService: ChainedErrorHandler {
    private weak var hostViewController: UIViewController?

    init(hostViewController: UIViewController) {
        self.hostViewController = hostViewController
    }

    func process(_ error: Error) async -> Bool {
        await withCheckedContinuation { continuation in
            let alertController = composeAlert(for: error, continuation: continuation)

            guard let hostViewController = hostViewController else {
                continuation.resume(returning: false)
                return
            }

            DispatchQueue.main.async {
                hostViewController.present(alertController, animated: true, completion: nil)
            }
        }
    }

    func composeAlert(for error: Error,
                      continuation: CheckedContinuation<Bool, Never>) -> UIAlertController {

        let alertController = UIAlertController(title: "An error has occured",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { _ in
            continuation.resume(returning: true)
        }

        alertController.addAction(okAction)

        return alertController
    }
}
