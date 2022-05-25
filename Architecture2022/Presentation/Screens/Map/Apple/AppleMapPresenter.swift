import MapKit
import TIAppleMapUtils
import TIMapUtils

final class AppleMapPresenter: MapPresenter {
    weak var mapView: MKMapView?

    private var mapManager: AppleMapManager<Office>?

    override func show(officess: [Office]) {
        guard let mapView = mapView else {
            return
        }

        mapManager = AppleMapManager(map: mapView,
                                     positionGetter: {
            guard let lat = Double($0.geoLatitude), let lng = Double($0.geoLongitude) else {
                return nil
            }

            return CLLocationCoordinate2D(latitude: lat, longitude: lng)
        },
                                     clusteringIdentifierGetter: { $0.type.rawValue },
                                     selectPlacemarkHandler: {
            debugPrint("Office \($0) was tapped at")
            return true
        })

        DispatchQueue.main.async { [mapManager] in
            mapManager?.set(items: officess)
        }
    }

    override func show(error: ErrorResponse) {
        // nothing
    }
}
