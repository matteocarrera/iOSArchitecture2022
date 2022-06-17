
import Alamofire
import TINetworking

public extension EndpointRequest {
    /**
     Авторизация по логину и паролю

     - parameter body: Тело запроса на вход по логину и паролю 
     */
    static func loginPasswordRequest(body: LoginPasswordRequestBody, server: Server? = nil, security: [[String]]? = nil) -> EndpointRequest<LoginPasswordRequestBody, TokensResponse> {
        .init(templatePath: "/api/v3/mobile/auth/login/password/",
              method: .init(rawValue: "POST"),
              body: body,
              headerParameters: nil,
              acceptableStatusCodes: [200, 400, 403, 500],
              security: security ?? [], // note: OR requirement is not supported by swagger-codegen
              server: server)
    }
    /**
     Авторизация по телефону и смс коду

     - parameter body: Тело запроса на вход по телефону и смс коду 
     */
    static func loginSMSRequest(body: LoginSMSRequestBody, server: Server? = nil, security: [[String]]? = nil) -> EndpointRequest<LoginSMSRequestBody, TokensResponse> {
        .init(templatePath: "/api/v3/mobile/auth/login/sms/",
              method: .init(rawValue: "POST"),
              body: body,
              headerParameters: nil,
              acceptableStatusCodes: [200, 400, 403, 500],
              security: security ?? [], // note: OR requirement is not supported by swagger-codegen
              server: server)
    }
    /**
     Отправка смс для получения кода авторизации пользователя

     - parameter body: Тело запроса на запрос смс кода для входа 
     */
    static func sMSSendRequest(body: SMSSendRequestBody, server: Server? = nil, security: [[String]]? = nil) -> EndpointRequest<SMSSendRequestBody, SMSSendResponse> {
        .init(templatePath: "/api/v3/mobile/auth/sms/send/",
              method: .init(rawValue: "POST"),
              body: body,
              headerParameters: nil,
              acceptableStatusCodes: [200, 400, 403, 500],
              security: security ?? [], // note: OR requirement is not supported by swagger-codegen
              server: server)
    }
    /**
     Запрос на обновление access и refresh токенов

     - parameter body: Тело запроса на обновление access и refresh токенов 
     */
    static func tokenRenewRequest(body: TokensRenewRequestBody, server: Server? = nil, security: [[String]]? = nil) -> EndpointRequest<TokensRenewRequestBody, TokensResponse> {
        .init(templatePath: "/api/v3/mobile/auth/tokens/renew/",
              method: .init(rawValue: "POST"),
              body: body,
              headerParameters: nil,
              acceptableStatusCodes: [200, 400, 403, 404, 500],
              security: security ?? [], // note: OR requirement is not supported by swagger-codegen
              server: server)
    }
}
