
import Alamofire
import TINetworking

public extension EndpointRequest {
    /**
     Запрос офисов на карте

     - parameter body: Тело запроса на получение офисов 
     */
    static func graphQLRequest(body: GraphQLRequestBody, server: Server? = nil, security: [[String]]? = nil) -> EndpointRequest<GraphQLRequestBody, GraphQLOfficesResponse> {
        .init(templatePath: "/graphql",
              method: .init(rawValue: "POST"),
              body: body,
              headerParameters: nil,
              acceptableStatusCodes: [200],
              security: security ?? [], // note: OR requirement is not supported by swagger-codegen
              server: server)
    }
}
