import UIKit
import TIMapUtils

final class OfficeMarkerIconFactory: DefaultCachableMarkerIconFactory<Office, NSString> {
    init() {
        super.init { office, _ in
            switch office.type {
            case .postamat:
                return #imageLiteral(resourceName: "PinPostamat")
            case .pvz:
                return #imageLiteral(resourceName: "PinPvz")
            }
        } cacheKeyProvider: { office, _ in
            office.type.rawValue as NSString
        }
    }

    override func postprocess(icon: UIImage) -> UIImage {
        let icon = super.postprocess(icon: icon)

        guard let cgIcon = icon.cgImage else {
            return UIImage()
        }

        let format = UIGraphicsImageRendererFormat()
        format.opaque = false

        let maxNewSize = CGSize(width: 48, height: 48)

        let transformOperation = TransformDrawingOperation(image: cgIcon,
                                                           imageSize: icon.size,
                                                           maxNewSize: maxNewSize,
                                                           resizeMode: .scaleAspectFit)

        let renderer = UIGraphicsImageRenderer(size: maxNewSize,
                                               format: format)

        return renderer.image { context in
            transformOperation.apply(in: context.cgContext)
        }
    }
}
