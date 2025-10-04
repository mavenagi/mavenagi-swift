import Foundation

public struct ConversationGroupBy: Codable, Hashable, Sendable {
    /// Limits the number of groups returned (defaults to 100 if omitted).
    public let limit: Int?
    /// Field used for data grouping.
    public let field: ConversationField
    /// Numeric ranges for grouping data into predefined buckets. Applies only to numeric fields.
    public let ranges: [Range]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        limit: Int? = nil,
        field: ConversationField,
        ranges: [Range]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.limit = limit
        self.field = field
        self.ranges = ranges
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.limit = try container.decodeIfPresent(Int.self, forKey: .limit)
        self.field = try container.decode(ConversationField.self, forKey: .field)
        self.ranges = try container.decodeIfPresent([Range].self, forKey: .ranges)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.limit, forKey: .limit)
        try container.encode(self.field, forKey: .field)
        try container.encodeIfPresent(self.ranges, forKey: .ranges)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case limit
        case field
        case ranges
    }
}