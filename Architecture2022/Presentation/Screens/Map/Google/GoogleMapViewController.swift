import TIUIKitCore
import GoogleMaps

final class GoogleMapViewController: BaseViewController<GMSMapView, GoogleMapPresenter> {
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }
}
