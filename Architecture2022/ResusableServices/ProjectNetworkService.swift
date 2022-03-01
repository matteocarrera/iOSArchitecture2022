import TINetworking
import Moya
import TISwiftUtils
import TIMoyaNetworking

final class ProjectNetworkService: DefaultRecoverableJsonNetworkService<ErrorResponse> {
    @Weaver(.reference)
    var jsonCodingService: JsonCodingService

    init(injecting resolver: ProjectNetworkServiceDependencyResolver) {
        super.init(session: SessionFactory(timeoutInterval: 60).createSession(),
                   jsonDecoder: resolver.jsonCodingService.jsonDecoder,
                   jsonEncoder: resolver.jsonCodingService.jsonEncoder)
    }

    func process<B: Encodable, S: Decodable, RF: RequestFactory>(recoverableRequest: RF,
                                                                 prependErrorHandlers: [ErrorHandler] = [],
                                                                 appendErrorHandlers: [ErrorHandler] = []) async -> Result<S, ErrorResponse> where RF.Body == B, RF.CreateFailure == ErrorResponse {

        await process(recoverableRequest: recoverableRequest,
                      prependErrorHandlers: prependErrorHandlers,
                      appendErrorHandlers: appendErrorHandlers,
                      mapMoyaError: { $0.convertToErrorResponse() })
    }

    func process<B: Encodable, S: Decodable, RF: RequestFactory>(recoverableRequest: RF,
                                                                 errorHandlers: [ErrorHandler]) async -> Result<S, ErrorResponse> where RF.Body == B, RF.CreateFailure == ErrorResponse {

        await process(recoverableRequest: recoverableRequest,
                      errorHandlers: errorHandlers,
                      mapMoyaError: { $0.convertToErrorResponse() })
    }

    func process<B: Encodable, S: Decodable>(request: EndpointRequest<B>) async -> Result<S, ErrorResponse>{
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
