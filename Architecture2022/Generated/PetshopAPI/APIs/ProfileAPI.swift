
import Alamofire
import TINetworking

public extension EndpointRequest {
    /**
     Отправка кода по СМС или почте, также повторная отправка кода

     - parameter body: Тело запроса для получения кода подтверждения 
     */
    static func profileCommunicationRequest(body: ProfileCommunicationRequestBody, server: Server? = nil, security: [[String]]? = nil) -> EndpointRequest<ProfileCommunicationRequestBody, ProfileCommunicationResponse> {
        .init(templatePath: "/api/v3/mobile/profile/communication/",
              method: .init(rawValue: "PUT"),
              body: body,
              headerParameters: nil,
              acceptableStatusCodes: [200, 400, 401, 403, 429, 500],
              security: security ?? [["AccessTokenAuth"]], // note: OR requirement is not supported by swagger-codegen
              server: server)
    }
    /**
     Запрос на получение информации о пользователе

     */
    static func profileRequest(server: Server? = nil, security: [[String]]? = nil) -> EndpointRequest<Nothing, ProfileResponse> {
        .init(templatePath: "/api/v3/mobile/profile/",
              method: .init(rawValue: "GET"),
              body: nil,
              headerParameters: nil,
              acceptableStatusCodes: [200, 400, 401, 404, 500],
              security: security ?? [["AccessTokenAuth"]], // note: OR requirement is not supported by swagger-codegen
              server: server)
    }
}
