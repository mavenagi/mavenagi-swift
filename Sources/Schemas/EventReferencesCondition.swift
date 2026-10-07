import Foundation

/// A condition on the entities an event references -- the conversation it is about, the
/// intelligent field whose value changed, the user who acted.
/// 
/// A set relation between the entities the event references and the ones named here.
public struct EventReferencesCondition: Codable, Hashable, Sendable {
    /// The set relation to apply. The event's references are the left-hand set.
    public let `operator`: SetRelationOperator
    /// The entities to match, at most 50. A conversation message is identified by its conversation, so give the conversation as `scopeEntityId` when naming one. An event that references a message also references its conversation, so `EQ` and `SUBSET_OF` must name both.
    public let references: [ScopedEntity]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        operator: SetRelationOperator,
        references: [ScopedEntity],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.operator = `operator`
        self.references = references
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operator = try container.decode(SetRelationOperator.self, forKey: .operator)
        self.references = try container.decode([ScopedEntity].self, forKey: .references)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.operator, forKey: .operator)
        try container.encode(self.references, forKey: .references)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case `operator`
        case references
    }
}