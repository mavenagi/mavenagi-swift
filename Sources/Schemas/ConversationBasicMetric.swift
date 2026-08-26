import Foundation

public struct ConversationBasicMetric: Codable, Hashable, Sendable {
    /// Field to apply the metric to.
    public let targetField: ConversationField
    /// Fully specified ID of the intelligent field. Required when `targetField` is
    /// `IntelligentField`, and ignored otherwise.
    public let intelligentFieldId: EntityId?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        targetField: ConversationField,
        intelligentFieldId: EntityId? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.targetField = targetField
        self.intelligentFieldId = intelligentFieldId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.targetField = try container.decode(ConversationField.self, forKey: .targetField)
        self.intelligentFieldId = try container.decodeIfPresent(EntityId.self, forKey: .intelligentFieldId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.targetField, forKey: .targetField)
        try container.encodeIfPresent(self.intelligentFieldId, forKey: .intelligentFieldId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case targetField
        case intelligentFieldId
    }
}