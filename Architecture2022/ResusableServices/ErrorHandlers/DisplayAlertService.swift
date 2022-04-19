import UIKit
import TIMoyaNetworking

final class DisplayAlertService: AsyncErrorHandler {
    weak var hostViewController: UIViewController?

    // MARK: - ErrorHandler

    func handle(_ error: EndpointErrorResult<ErrorResponse>) async -> Bool {
        await withCheckedContinuation { continuation in
            DispatchQueue.main.async { [weak hostViewController] in
                let alertController = Self.composeAlert(for: error, continuation: continuation)

                guard let hostViewController = hostViewController else {
                    continuation.resume(returning: false)
                    return
                }

                hostViewController.present(alertController, animated: true, completion: nil)
            }
        }
    }

    func update(hostViewController: UIViewController?) {
        self.hostViewController = hostViewController
    }

    private static func composeAlert(for error: EndpointErrorResult<ErrorResponse>,
                                     continuation: CheckedContinuation<Bool, Never>) -> UIAlertController {

        let alertController = UIAlertController(title: "An error has occured",
                                                message: error.errorResponse.message,
                                                preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { _ in
            continuation.resume(returning: false)
        }

        alertController.addAction(okAction)

        return alertController
    }
}
