
import Foundation
import TIFoundationUtils


/** Тело запроса на запрос смс кода для входа */

public struct SMSSendRequestBody: Codable, Equatable {

    /** Номер телефона */
    public var phone: String

    private enum CodingKeys: String, CodingKey {
        case phone
    }

    public init(phone: String) {
        self.phone = phone
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        phone = try container.decode(String.self, forKey: .phone)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(phone, forKey: .phone)
    }

}
