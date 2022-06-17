
import Foundation
import TIFoundationUtils


/** Офис на карте */

public struct Office: Codable, Equatable {

    /** Идентификатор */
    public var id: Int
    public var type: OfficeType
    /** Широта */
    public var geoLatitude: String
    /** Долгота */
    public var geoLongitude: String

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case geoLatitude
        case geoLongitude
    }

    public init(id: Int, type: OfficeType, geoLatitude: String, geoLongitude: String) {
        self.id = id
        self.type = type
        self.geoLatitude = geoLatitude
        self.geoLongitude = geoLongitude
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        type = try container.decode(OfficeType.self, forKey: .type)
        geoLatitude = try container.decode(String.self, forKey: .geoLatitude)
        geoLongitude = try container.decode(String.self, forKey: .geoLongitude)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(geoLatitude, forKey: .geoLatitude)
        try container.encode(geoLongitude, forKey: .geoLongitude)
    }

}
