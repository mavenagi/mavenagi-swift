import Foundation

/// Computes the median value of the specified field.
public struct ConversationMedian: Codable, Hashable, Sendable {
    /// Numeric field to apply the metric to.
    public let targetField: NumericConversationField
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        targetField: NumericConversationField,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.targetField = targetField
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.targetField = try container.decode(NumericConversationField.self, forKey: .targetField)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.targetField, forKey: .targetField)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case targetField
    }
}