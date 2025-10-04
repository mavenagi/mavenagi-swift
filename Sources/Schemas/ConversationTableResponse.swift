import Foundation

public struct ConversationTableResponse: Codable, Hashable, Sendable {
    /// Column headers in the table, aligning with the column definitions specified in the request.
    public let headers: [String]
    /// The dataset rows, where each row represents a unique combination of grouping field values. 
    /// The identifier map contains grouping field names mapped to their respective values.
    /// The data map contains column headers mapped to their respective metric values.
    public let rows: [ConversationRow]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        headers: [String],
        rows: [ConversationRow],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.headers = headers
        self.rows = rows
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.headers = try container.decode([String].self, forKey: .headers)
        self.rows = try container.decode([ConversationRow].self, forKey: .rows)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.headers, forKey: .headers)
        try container.encode(self.rows, forKey: .rows)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case headers
        case rows
    }
}