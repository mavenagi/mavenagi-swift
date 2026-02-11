import Foundation

/// A precondition based on the computed value of an intelligent field on the conversation.
/// 
/// The structure of this precondition follows `LHS OP RHS`, where the LHS is
/// the ID of the intelligent field (<referenceId, appId>).  Available
/// operators and the corresponding types of the RHS depends on the
/// validationType of the intelligent field.
/// 
/// Note: in early beta, only opt-in apps and organizations/agents can
/// specify intelligent field preconditions.  Otherwise, the request will be
/// rejected.
public struct IntelligentFieldPrecondition: Codable, Hashable, Sendable {
    /// The ID of the intelligent field.
    public let fieldIdWithoutAgent: EntityIdWithoutAgent
    /// The condition to evaluate against the field's value.
    public let fieldCondition: IntelligentFieldCondition
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        fieldIdWithoutAgent: EntityIdWithoutAgent,
        fieldCondition: IntelligentFieldCondition,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.fieldIdWithoutAgent = fieldIdWithoutAgent
        self.fieldCondition = fieldCondition
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fieldIdWithoutAgent = try container.decode(EntityIdWithoutAgent.self, forKey: .fieldIdWithoutAgent)
        self.fieldCondition = try container.decode(IntelligentFieldCondition.self, forKey: .fieldCondition)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.fieldIdWithoutAgent, forKey: .fieldIdWithoutAgent)
        try container.encode(self.fieldCondition, forKey: .fieldCondition)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case fieldIdWithoutAgent
        case fieldCondition
    }
}