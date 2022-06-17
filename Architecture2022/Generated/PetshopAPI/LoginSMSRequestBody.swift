
import Foundation
import TIFoundationUtils


/** Тело запроса на вход по телефону и смс коду */

public struct LoginSMSRequestBody: Codable, Equatable {

    /** Номер телефона */
    public var phone: String
    /** Код из смс */
    public var smsCode: String

    private enum CodingKeys: String, CodingKey {
        case phone
        case smsCode
    }

    public init(phone: String, smsCode: String) {
        self.phone = phone
        self.smsCode = smsCode
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        phone = try container.decode(String.self, forKey: .phone)
        smsCode = try container.decode(String.self, forKey: .smsCode)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(phone, forKey: .phone)
        try container.encode(smsCode, forKey: .smsCode)
    }

}
