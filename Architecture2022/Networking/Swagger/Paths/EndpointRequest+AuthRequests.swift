import TINetworking
import Foundation

extension EndpointRequest {
    static func apiV3MobileAuthLoginPassword(body: LoginRequestBody) -> EndpointRequest<LoginRequestBody> {
        .init(templatePath: "/api/v3/mobile/auth/login/password/",
              method: .post,
              body: body,
              acceptableStatusCodes: [200, 400, 403, 500],
              server: .default)
    }

    static func apiV3MobileAuthTokensRenew(body: RenewTokenRequestBody) -> EndpointRequest<RenewTokenRequestBody> {
        .init(templatePath: "/api/v3/mobile/auth/tokens/renew/",
              method: .post,
              body: body,
              acceptableStatusCodes: [200, 400, 403, 404, 500],
              server: .default)
    }
}
