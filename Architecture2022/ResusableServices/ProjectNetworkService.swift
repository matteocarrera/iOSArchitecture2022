import TINetworking
import Moya
import TISwiftUtils
import TIMoyaNetworking
import TIFoundationUtils

final class ProjectNetworkService: DefaultRecoverableJsonNetworkService<ErrorResponse> {
    @Weaver(.reference)
    var jsonCodingConfigurator: ProjectJsonCodingConfigurator

    @Weaver(.reference)
    var tokenStorageService: TokenStorageService

    init(injecting resolver: ProjectNetworkServiceDependencyResolver) {
        super.init(session: SessionFactory(timeoutInterval: 60).createSession(),
                   jsonDecoder: resolver.jsonCodingConfigurator.jsonDecoder,
                   jsonEncoder: resolver.jsonCodingConfigurator.jsonEncoder,
                   defaultServer: .default)

        let accessTokenPlugin = AccessTokenAuthPlugin { [tokenStorageService] in
            tokenStorageService.accessToken?.value
        }

        plugins.append(accessTokenPlugin)
    }

    override func createProvider() -> MoyaProvider<SerializedRequest> {
        MoyaProvider<SerializedRequest>(callbackQueue: .global(qos: .default),
                                        session: SessionFactory(timeoutInterval: 60).createSession(),
                                        plugins: plugins)
    }

    func process<B: Encodable, S: Decodable>(request: EndpointRequest<B, S>,
                                             prependErrorHandlers: [ErrorHandler] = [],
                                             appendErrorHandlers: [ErrorHandler] = []) async -> Result<S, ErrorResponse> {

        await process(request: request,
                      prependErrorHandlers: prependErrorHandlers,
                      appendErrorHandlers: appendErrorHandlers,
                      mapMoyaError: { $0.convertToErrorResponse() })
    }

    func process<B: Encodable, S: Decodable>(request: EndpointRequest<B, S>,
                                             errorHandlers: [ErrorHandler]) async -> Result<S, ErrorResponse> {

        await process(request: request,
                      errorHandlers: errorHandlers,
                      mapMoyaError: { $0.convertToErrorResponse() })
    }

    func process<B: Encodable, S: Decodable>(request: EndpointRequest<B, S>) async -> Result<S, ErrorResponse>{
        await process(request: request,
                      mapMoyaError: { $0.convertToErrorResponse() })
    }
}

private extension MoyaError {
    func convertToErrorResponse() -> ErrorResponse {
        switch self {
        case .underlying:
            return ErrorResponse(errorCode: .unknown,
                                 message: "Нет соединения с сетью 😔 Проверьте соединение с сетью и повторите попытку")

        case .objectMapping:
            return ErrorResponse(errorCode: .unknown,
                                 message: "Ошибка 😔")

        default:
            return ErrorResponse(errorCode: .unknown,
                                 message: "Ошибка 😔")
        }
    }
}
