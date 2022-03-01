import Foundation
import TIFoundationUtils

struct JsonCodingService {
    @Weaver(.reference)
    var dateFormattersReusePool: DateFormattersReusePool

    let jsonEncoder: JSONEncoder
    let jsonDecoder: JSONDecoder

    init(injecting resolver: JsonCodingServiceDependencyResolver) {
        self.jsonEncoder = JSONEncoder()
        self.jsonDecoder = JSONDecoder()

        guard let userInfoKey = CodingUserInfoKey.dateFormattersReusePool else {
            assertionFailure("Unable to create dateFormattersReusePool CodingUserInfoKey")
            return
        }

        jsonDecoder.userInfo.updateValue(resolver.dateFormattersReusePool, forKey: userInfoKey)
        jsonEncoder.userInfo.updateValue(resolver.dateFormattersReusePool, forKey: userInfoKey)
    }
}
