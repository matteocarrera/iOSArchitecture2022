import YandexMapsMobile
import MapKit
import TIMapUtils

class MapPresenter: NSObject {
    let officessService: OfficessService

    let officeMarkerIconFactory = OfficeMarkerIconFactory().asAnyMarkerIconFactory()

    let officeClusterMarkerIconFactory = DefaultClusterMarkerIconFactory<Office>()

    init(officessService: OfficessService) {
        self.officessService = officessService
    }

    func viewDidLoad() {
        Task {
            switch await officessService.getOfficess() {
            case let .success(officess):
                show(officess: officess)
            case let.failure(errorResponse):
                show(error: errorResponse)
            }
        }
    }

    func show(officess: [Office]) {
        // override in subclass
    }

    func show(error: ErrorResponse) {
        // override in subclass
    }
}


