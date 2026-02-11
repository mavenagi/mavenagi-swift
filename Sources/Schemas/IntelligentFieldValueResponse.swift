import Foundation

/// A single computed value for an intelligent field on a specific entity
public struct IntelligentFieldValueResponse: Codable, Hashable, Sendable {
    /// The intelligent field that this value belongs to
    public let fieldId: EntityId
    /// The entity this value is for
    public let entityId: EntityId
    /// The computed value (typed according to validationType)
    public let value: JSONValue?
    /// Optional model-provided confidence for the value
    public let confidence: Double?
    /// Optional short rationale/explanation from the model
    public let rationale: String?
    /// The date and time this value was computed
    public let createdAt: Date?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        fieldId: EntityId,
        entityId: EntityId,
        value: JSONValue? = nil,
        confidence: Double? = nil,
        rationale: String? = nil,
        createdAt: Date? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.fieldId = fieldId
        self.entityId = entityId
        self.value = value
        self.confidence = confidence
        self.rationale = rationale
        self.createdAt = createdAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fieldId = try container.decode(EntityId.self, forKey: .fieldId)
        self.entityId = try container.decode(EntityId.self, forKey: .entityId)
        self.value = try container.decodeIfPresent(JSONValue.self, forKey: .value)
        self.confidence = try container.decodeIfPresent(Double.self, forKey: .confidence)
        self.rationale = try container.decodeIfPresent(String.self, forKey: .rationale)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.fieldId, forKey: .fieldId)
        try container.encode(self.entityId, forKey: .entityId)
        try container.encodeIfPresent(self.value, forKey: .value)
        try container.encodeIfPresent(self.confidence, forKey: .confidence)
        try container.encodeIfPresent(self.rationale, forKey: .rationale)
        try container.encodeIfPresent(self.createdAt, forKey: .createdAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case fieldId
        case entityId
        case value
        case confidence
        case rationale
        case createdAt
    }
}