import Foundation

public struct BotLogicIntelligentFieldDetail: Codable, Hashable, Sendable {
    public let fieldId: EntityIdWithoutAgent
    public let name: String
    public let value: String?
    public let confidence: Double?
    public let rationale: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        fieldId: EntityIdWithoutAgent,
        name: String,
        value: String? = nil,
        confidence: Double? = nil,
        rationale: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.fieldId = fieldId
        self.name = name
        self.value = value
        self.confidence = confidence
        self.rationale = rationale
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fieldId = try container.decode(EntityIdWithoutAgent.self, forKey: .fieldId)
        self.name = try container.decode(String.self, forKey: .name)
        self.value = try container.decodeIfPresent(String.self, forKey: .value)
        self.confidence = try container.decodeIfPresent(Double.self, forKey: .confidence)
        self.rationale = try container.decodeIfPresent(String.self, forKey: .rationale)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.fieldId, forKey: .fieldId)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.value, forKey: .value)
        try container.encodeIfPresent(self.confidence, forKey: .confidence)
        try container.encodeIfPresent(self.rationale, forKey: .rationale)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case fieldId
        case name
        case value
        case confidence
        case rationale
    }
}