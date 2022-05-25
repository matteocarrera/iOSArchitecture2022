import TIUIKitCore
import MapKit

final class AppleMapViewController: BaseViewController<MKMapView, AppleMapPresenter> {
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }
}
