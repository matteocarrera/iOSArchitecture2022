import TINetworking

import Alamofire

extension EndpointRequest {
    static func apiV3MobileProfile(bearerToken: String) -> EndpointRequest<EmptyBody> {
        .init(templatePath: "/api/v3/mobile/profile/",
              method: .get,
              body: EmptyBody(),
              headerParameters: HTTPHeaders(["X-Bearer-Token": bearerToken]),
              acceptableStatusCodes: [200, 400, 401, 404, 500],
              server: .default)
    }
}

