
import Foundation
import TIFoundationUtils


/** Ответ на запрос кода подтверждения */

public struct ProfileCommunicationResponse: Codable, Equatable {

    /** Время действия кода в секундах */
    public var lifetime: Int?

    private enum CodingKeys: String, CodingKey {
        case lifetime
    }

    public init(lifetime: Int? = nil) {
        self.lifetime = lifetime
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lifetime = try container.decode(Int?.self, forKey: .lifetime, required: false)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(lifetime, forKey: .lifetime, required: false)
    }

}
