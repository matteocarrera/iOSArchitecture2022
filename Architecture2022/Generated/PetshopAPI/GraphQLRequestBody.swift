
import Foundation
import TIFoundationUtils


/** Тело запроса на получение офисов */

public struct GraphQLRequestBody: Codable, Equatable {

    public var operationName: OperationName
    /** GraphQL запрос */
    public var query: String

    private enum CodingKeys: String, CodingKey {
        case operationName
        case query
    }

    public init(operationName: OperationName, query: String) {
        self.operationName = operationName
        self.query = query
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        operationName = try container.decode(OperationName.self, forKey: .operationName)
        query = try container.decode(String.self, forKey: .query)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(operationName, forKey: .operationName)
        try container.encode(query, forKey: .query)
    }

}
