import GoogleMaps
import TIGoogleMapUtils

final class GoogleMapPresenter: MapPresenter {
    weak var mapView: GMSMapView?
    
    private var mapManager: GoogleMapManager<Office>?
    
    override func show(officess: [Office]) {
        guard let mapView = mapView else {
            return
        }

        mapManager = GoogleMapManager(map: mapView,
                                      positionGetter: {
            guard let lat = Double($0.geoLatitude), let lng = Double($0.geoLongitude) else {
                return nil
            }

            return CLLocationCoordinate2D(latitude: lat, longitude: lng)
        },
//                                      iconFactory: officeMarkerIconFactory,
//                                      clusterIconFactory: officeClusterMarkerIconFactory,
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
