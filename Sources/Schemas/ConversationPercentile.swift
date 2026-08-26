import Foundation

/// Calculates specified percentile for a numeric field.
public struct ConversationPercentile: Codable, Hashable, Sendable {
    /// Numeric field to apply the metric to.
    public let targetField: NumericConversationField
    /// Fully specified ID of the intelligent field. Required when `targetField` is
    /// `IntelligentField`, and ignored otherwise.
    public let intelligentFieldId: EntityId?
    /// The percentile to calculate. Example: 25 computes the 25th percentile.
    public let percentile: Double
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        targetField: NumericConversationField,
        intelligentFieldId: EntityId? = nil,
        percentile: Double,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.targetField = targetField
        self.intelligentFieldId = intelligentFieldId
        self.percentile = percentile
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.targetField = try container.decode(NumericConversationField.self, forKey: .targetField)
        self.intelligentFieldId = try container.decodeIfPresent(EntityId.self, forKey: .intelligentFieldId)
        self.percentile = try container.decode(Double.self, forKey: .percentile)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.targetField, forKey: .targetField)
        try container.encodeIfPresent(self.intelligentFieldId, forKey: .intelligentFieldId)
        try container.encode(self.percentile, forKey: .percentile)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case targetField
        case intelligentFieldId
        case percentile
    }
}