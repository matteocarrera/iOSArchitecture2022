import TIUIKitCore
import YandexMapsMobile

final class YandexMapViewController: BaseViewController<YMKMapView, YandexMapPresenter> {
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }
}
