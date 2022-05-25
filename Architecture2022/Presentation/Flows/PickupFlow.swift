import UIKit
import YandexMapsMobile
import GoogleMaps

struct PickupFlow {
    private let yandexMapsApiKey = "XXX"
    private let googleMapsApiKey = "XXX"

    @Weaver(.reference)
    private var pickupService: OfficessService

    private let yandexMapViewController: YandexMapViewController
    private let googleMapViewController: GoogleMapViewController
    private let appleMapViewController: AppleMapViewController

    init(injecting: PickupFlowDependencyResolver) {
        YMKMapKit.setApiKey(yandexMapsApiKey)
        
        let yandexMapPresenter = YandexMapPresenter(officessService: injecting.pickupService)

        self.yandexMapViewController = YandexMapViewController(viewModel: yandexMapPresenter)

        yandexMapPresenter.view = yandexMapViewController.customView

        GMSServices.provideAPIKey(googleMapsApiKey)

        let googleMapPresenter = GoogleMapPresenter(officessService: injecting.pickupService)

        self.googleMapViewController = GoogleMapViewController(viewModel: googleMapPresenter)

        googleMapPresenter.mapView = googleMapViewController.customView

        let appleMapPresenter = AppleMapPresenter(officessService: injecting.pickupService)

        self.appleMapViewController = AppleMapViewController(viewModel: appleMapPresenter)

        appleMapPresenter.mapView = appleMapViewController.customView
    }

    func start(on rootNavigation: UINavigationController) {
        rootNavigation.pushViewController(yandexMapViewController, animated: false)
    }
}
