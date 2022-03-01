import Foundation

struct ErrorResponse: Codable {
    let errorCode: ErrorType
    let message: String
}

extension ErrorResponse: Error {}
