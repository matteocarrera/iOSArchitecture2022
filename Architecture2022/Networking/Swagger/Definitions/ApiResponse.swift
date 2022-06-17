import TINetworking
import Moya

extension ErrorResponse: Error {}

extension ErrorResponse {
    static var `default`: Self {
        .init(errorCode: .unknown,
              errorMessage: "Ошибка 😔")
    }
}

typealias ApiResponse<ResponseType> = Result<ResponseType, ErrorCollection<ErrorResponse>>

extension EndpointErrorResult where ApiError == ErrorResponse, NetworkError == MoyaError {
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
                                 errorMessage: "Нет соединения с сетью 😔 Проверьте соединение с сетью и повторите попытку")

        case .objectMapping:
            return ErrorResponse(errorCode: .unknown,
                                 errorMessage: "Ошибка 😔")

        default:
            return ErrorResponse(errorCode: .unknown,
                                 errorMessage: "Ошибка 😔")
        }
    }
}
