import Foundation

/// Filters combine with AND: a charter must match every filter given. Within one filter, a
/// charter matches if it references any of the listed IDs. An empty list is the same as
/// omitting the filter.
public struct CharterSearchFilter: Codable, Hashable, Sendable {
    /// Only return charters referencing these actions. At most 50.
    public let actionIds: [EntityId]?
    /// Only return charters referencing these knowledge bases. At most 50.
    public let knowledgeBaseIds: [EntityId]?
    /// Only return charters whose precondition references these intelligent fields. At most 50.
    /// A charter reaches an intelligent field through its precondition, not by referencing it
    /// directly the way it does an action or a knowledge base.
    public let intelligentFieldIds: [EntityId]?
    /// Search the charters as this agent variant sees them. Its staged edits are included: a
    /// charter with a staged edit is read at that edit, a charter created in the variant is
    /// included, and a charter deleted in the variant, whether the delete is staged or already in
    /// its snapshot, is left out. If not provided, the request is rejected with
    /// `VARIANT_REQUIRED` while charters are versioned for the agent, and otherwise reads through
    /// the agent's single variant, as its snapshot has it, or the published charters while
    /// variant reads are off.
    public let variantId: EntityIdWithoutAgent?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        actionIds: [EntityId]? = nil,
        knowledgeBaseIds: [EntityId]? = nil,
        intelligentFieldIds: [EntityId]? = nil,
        variantId: EntityIdWithoutAgent? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.actionIds = actionIds
        self.knowledgeBaseIds = knowledgeBaseIds
        self.intelligentFieldIds = intelligentFieldIds
        self.variantId = variantId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.actionIds = try container.decodeIfPresent([EntityId].self, forKey: .actionIds)
        self.knowledgeBaseIds = try container.decodeIfPresent([EntityId].self, forKey: .knowledgeBaseIds)
        self.intelligentFieldIds = try container.decodeIfPresent([EntityId].self, forKey: .intelligentFieldIds)
        self.variantId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .variantId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.actionIds, forKey: .actionIds)
        try container.encodeIfPresent(self.knowledgeBaseIds, forKey: .knowledgeBaseIds)
        try container.encodeIfPresent(self.intelligentFieldIds, forKey: .intelligentFieldIds)
        try container.encodeIfPresent(self.variantId, forKey: .variantId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case actionIds
        case knowledgeBaseIds
        case intelligentFieldIds
        case variantId
    }
}