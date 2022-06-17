
import Foundation
import TIFoundationUtils


/** Профиль пользователя */

public struct ProfileResponse: Codable, Equatable {

    /** Имя пользователя */
    public var name: String

    private enum CodingKeys: String, CodingKey {
        case name
    }

    public init(name: String) {
        self.name = name
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
    }

}
