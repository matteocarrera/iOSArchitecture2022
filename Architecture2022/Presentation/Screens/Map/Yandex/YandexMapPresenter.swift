import YandexMapsMobile
import MapKit
import TIYandexMapUtils
import TIMapUtils

final class YandexMapPresenter: MapPresenter {
    var view: YMKMapView!
    
    private var map: YMKMap {
        view.mapWindow.map
    }
    
    private var mapManager: YandexMapManager<Office>?
    
    override func show(officess: [Office]) {
        mapManager = YandexMapManager(map: view,
                                      positionGetter: {
            guard let lat = Double($0.geoLatitude), let lng = Double($0.geoLongitude) else {
                return nil
            }

            return YMKPoint(latitude: lat, longitude: lng)
        },
                                      iconFactory: officeMarkerIconFactory,
                                      clusterIconFactory: officeClusterMarkerIconFactory,
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
