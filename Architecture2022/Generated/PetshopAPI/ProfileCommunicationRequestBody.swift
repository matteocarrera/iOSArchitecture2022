
import Foundation
import TIFoundationUtils


/** Тело запроса для получения кода подтверждения */

public struct ProfileCommunicationRequestBody: Codable, Equatable {

    /** Номер телефона или адрес почты */
    public var value: String
    public var communicationType: CommunicationType

    private enum CodingKeys: String, CodingKey {
        case value
        case communicationType
    }

    public init(value: String, communicationType: CommunicationType) {
        self.value = value
        self.communicationType = communicationType
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(String.self, forKey: .value)
        communicationType = try container.decode(CommunicationType.self, forKey: .communicationType)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(value, forKey: .value)
        try container.encode(communicationType, forKey: .communicationType)
    }

}
