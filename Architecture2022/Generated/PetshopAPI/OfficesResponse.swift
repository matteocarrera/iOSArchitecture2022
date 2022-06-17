
import Foundation
import TIFoundationUtils


/** Офисы на карте */

public struct OfficesResponse: Codable, Equatable {

    /** Список офисов */
    public var websiteOffices: [Office]

    private enum CodingKeys: String, CodingKey {
        case websiteOffices
    }

    public init(websiteOffices: [Office]) {
        self.websiteOffices = websiteOffices
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        websiteOffices = try container.decode([Office].self, forKey: .websiteOffices)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(websiteOffices, forKey: .websiteOffices)
    }

}
