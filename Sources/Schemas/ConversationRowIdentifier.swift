import Foundation

public struct ConversationRowIdentifier: Codable, Hashable, Sendable {
    /// The row's value for this grouping.
    public let value: FieldValue
    /// Field this grouping was on.
    public let field: ConversationField
    /// Which intelligent field this grouping was on, set when `field` is `IntelligentField`.
    public let intelligentFieldId: EntityId?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        value: FieldValue,
        field: ConversationField,
        intelligentFieldId: EntityId? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.value = value
        self.field = field
        self.intelligentFieldId = intelligentFieldId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(FieldValue.self, forKey: .value)
        self.field = try container.decode(ConversationField.self, forKey: .field)
        self.intelligentFieldId = try container.decodeIfPresent(EntityId.self, forKey: .intelligentFieldId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.value, forKey: .value)
        try container.encode(self.field, forKey: .field)
        try container.encodeIfPresent(self.intelligentFieldId, forKey: .intelligentFieldId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case value
        case field
        case intelligentFieldId
    }
}