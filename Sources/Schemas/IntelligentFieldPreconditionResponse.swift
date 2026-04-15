import Foundation

/// Response variant of IntelligentFieldPrecondition.
/// Includes the resolved display name of the intelligent field.
public struct IntelligentFieldPreconditionResponse: Codable, Hashable, Sendable {
    /// The ID of the intelligent field.
    public let fieldIdWithoutAgent: EntityIdWithoutAgent
    /// Human-readable display name of the intelligent field. Resolved server-side.
    public let name: String?
    /// The condition to evaluate against the field's value.
    public let fieldCondition: IntelligentFieldCondition
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        fieldIdWithoutAgent: EntityIdWithoutAgent,
        name: String? = nil,
        fieldCondition: IntelligentFieldCondition,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.fieldIdWithoutAgent = fieldIdWithoutAgent
        self.name = name
        self.fieldCondition = fieldCondition
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fieldIdWithoutAgent = try container.decode(EntityIdWithoutAgent.self, forKey: .fieldIdWithoutAgent)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.fieldCondition = try container.decode(IntelligentFieldCondition.self, forKey: .fieldCondition)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.fieldIdWithoutAgent, forKey: .fieldIdWithoutAgent)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encode(self.fieldCondition, forKey: .fieldCondition)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case fieldIdWithoutAgent
        case name
        case fieldCondition
    }
}