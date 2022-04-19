import TIMoyaNetworking
import Moya

extension ErrorResponse: Error {}

typealias ApiResponse<ResponseType> = Result<ResponseType, ErrorResponse>

extension EndpointErrorResult where E == ErrorResponse {
    var errorResponse: ErrorResponse {
        switch self {
        case let .apiError(errorResponse):
            return errorResponse
        case let .networkError(moyaError):
            return moyaError.convertToErrorResponse()
        }
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
