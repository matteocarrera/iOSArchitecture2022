import Foundation

struct Token: Codable {

    private enum CodingKeys: String, CodingKey {
        case name
        case value
        case expirationDate = "expiration"
    }

    var name: String
    var value: String
    var expirationDate: Date

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        value = try container.decode(String.self, forKey: .value)

        let dateFormatter = try decoder.userInfo.dateFormatter(for: APIDateFormat.yyyyMMddTHHmmssSZ)

        expirationDate = try container.decodeDate(forKey: .expirationDate,
                                                  using: dateFormatter)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(value, forKey: .value)

        let dateFormatter = try encoder.userInfo.dateFormatter(for: APIDateFormat.yyyyMMddTHHmmssSZ)

        try container.encode(date: expirationDate,
                             forKey: .expirationDate,
                             using: dateFormatter)
    }
}
