import UIKit
import TINetworking
import TIFoundationUtils

final class DisplayAlertService: EndpointRequestRetrier {
    typealias CompletionClosure = (EndpointRetryResult) -> Void

    typealias ErrorResult = ProjectNetworkService.ErrorType

    func validateAndRepair(errorResults: [ProjectNetworkService.ErrorType],
                           completion: @escaping CompletionClosure) -> Cancellable {

        let alertController = Self.composeAlert(for: errorResults, completion: completion)

        guard let hostViewController = hostViewController else {
            return Cancellables.nonCancellable()
        }

        DispatchQueue.main.async {
            hostViewController.present(alertController, animated: true, completion: nil)
        }

        return WeakTargetCancellable(target: alertController) { weakAlertController in
            DispatchQueue.main.async {
                weakAlertController?.dismiss(animated: true, completion: nil)
            }
        }
    }

    weak var hostViewController: UIViewController?

    // MARK: - ErrorHandler

    func update(hostViewController: UIViewController?) {
        self.hostViewController = hostViewController
    }

    private static func composeAlert(for errors: [ProjectNetworkService.ErrorType],
                                     completion: @escaping CompletionClosure) -> UIAlertController {

        let alertController = UIAlertController(title: "An error has occured",
                                                message: errors.last?.errorResponse.errorMessage,
                                                preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { _ in
            completion(.success(.doNotRetry))
        }

        alertController.addAction(okAction)

        return alertController
    }
}
