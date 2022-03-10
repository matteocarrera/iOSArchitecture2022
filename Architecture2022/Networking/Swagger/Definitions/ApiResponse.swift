extension ErrorResponse: Error {}

typealias ApiResponse<ResponseType> = Result<ResponseType, ErrorResponse>
