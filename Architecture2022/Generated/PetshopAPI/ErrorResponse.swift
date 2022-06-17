
import Foundation
import TIFoundationUtils


/** Ответ с текстом и кодом ошибки */

public struct ErrorResponse: Codable, Equatable {

    /** Код ошибки */
    public var errorCode: String
    /** Текст сообщения об ошибке */
    public var errorMessage: String

    private enum CodingKeys: String, CodingKey {
        case errorCode
        case errorMessage
    }

    public init(errorCode: String, errorMessage: String) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try container.decode(String.self, forKey: .errorCode)
        errorMessage = try container.decode(String.self, forKey: .errorMessage)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(errorCode, forKey: .errorCode)
        try container.encode(errorMessage, forKey: .errorMessage)
    }

}
