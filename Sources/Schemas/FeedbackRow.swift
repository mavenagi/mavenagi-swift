import Foundation

public struct FeedbackRow: Codable, Hashable, Sendable {
    /// The actual row data, where keys represent column headers and values contain the respective metric results.
    public let data: [String: CellData]
    /// Keyed by field, so it cannot represent two groupings that share a key - notably two
    /// intelligent fields. Use `identifiers`, which carries one entry per grouping in request
    /// order.
    public let identifier: [FeedbackField: FieldValue]
    /// One entry per grouping, in the order the groupings were requested.
    public let identifiers: [FeedbackRowIdentifier]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        data: [String: CellData],
        identifier: [FeedbackField: FieldValue],
        identifiers: [FeedbackRowIdentifier],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.data = data
        self.identifier = identifier
        self.identifiers = identifiers
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([String: CellData].self, forKey: .data)
        self.identifier = try container.decode([FeedbackField: FieldValue].self, forKey: .identifier)
        self.identifiers = try container.decode([FeedbackRowIdentifier].self, forKey: .identifiers)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.data, forKey: .data)
        try container.encode(self.identifier, forKey: .identifier)
        try container.encode(self.identifiers, forKey: .identifiers)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case data
        case identifier
        case identifiers
    }
}