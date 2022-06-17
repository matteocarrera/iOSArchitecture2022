
import Foundation
import TIFoundationUtils


/** Ответ на запрос кода авторизации пользователя */

public struct SMSSendResponse: Codable, Equatable {

    /** Время действия кода в секундах */
    public var lifetime: Int

    private enum CodingKeys: String, CodingKey {
        case lifetime
    }

    public init(lifetime: Int) {
        self.lifetime = lifetime
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lifetime = try container.decode(Int.self, forKey: .lifetime)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(lifetime, forKey: .lifetime)
    }

}
