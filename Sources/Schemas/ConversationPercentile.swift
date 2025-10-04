import Foundation

/// Calculates specified percentile for a numeric field.
public struct ConversationPercentile: Codable, Hashable, Sendable {
    /// Numeric field to apply the metric to.
    public let targetField: NumericConversationField
    /// The percentile to calculate. Example: 25 computes the 25th percentile.
    public let percentile: Double
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        targetField: NumericConversationField,
        percentile: Double,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.targetField = targetField
        self.percentile = percentile
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.targetField = try container.decode(NumericConversationField.self, forKey: .targetField)
        self.percentile = try container.decode(Double.self, forKey: .percentile)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.targetField, forKey: .targetField)
        try container.encode(self.percentile, forKey: .percentile)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case targetField
        case percentile
    }
}