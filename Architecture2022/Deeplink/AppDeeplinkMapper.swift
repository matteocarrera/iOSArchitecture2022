import Foundation
import TIDeeplink

struct AppDeeplinkMapper: DeeplinkMapper {
    func map(url: URL) -> DeeplinkType? {
        guard let host = url.host else {
            return nil
        }
        return AppDeeplink(rawValue: host)
    }
}
