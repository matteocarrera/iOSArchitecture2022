
import Foundation
import TIFoundationUtils


/** Ответ GraphQL с офисами на карте */

public struct GraphQLOfficesResponse: Codable, Equatable {

    public var data: OfficesResponse

    private enum CodingKeys: String, CodingKey {
        case data
    }

    public init(data: OfficesResponse) {
        self.data = data
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode(OfficesResponse.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(data, forKey: .data)
    }

}
