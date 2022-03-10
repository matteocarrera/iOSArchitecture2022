import TIMoyaNetworking
import Alamofire

public struct AccessTokenAuthPlugin: AdditionalHeadersPlugin {
    public typealias HeaderValueProvider = () -> String?

    private let headerValueProvider: HeaderValueProvider

    public init(headerValueProvider: @escaping HeaderValueProvider) {
        self.headerValueProvider = headerValueProvider
    }

    public var additionalHeaders: HTTPHeaders {
        guard let value = headerValueProvider() else {
            return HTTPHeaders()
        }

        return HTTPHeaders(["X-Bearer-Token": value])
    }
}
