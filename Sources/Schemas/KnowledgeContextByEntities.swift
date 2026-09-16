import Foundation

public struct KnowledgeContextByEntities: Codable, Hashable, Sendable {
    /// The entities whose documents should be retrievable, in addition to the agent's own
    /// knowledge. Each `entityId` must be fully specified and must belong to the organization
    /// and agent the request is made against; one that does not is rejected. Entities are never
    /// silently dropped, which would omit exactly the documents the caller asked to bring into
    /// scope.
    /// 
    /// `AGENT` and `FEEDBACK` are rejected: neither has an internal form to resolve to, and
    /// `AGENT` in particular is redundant here because the agent's own knowledge is always in
    /// scope. Every other `EntityType` is accepted.
    public let entities: JSONValue
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        entities: JSONValue,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.entities = entities
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.entities = try container.decode(JSONValue.self, forKey: .entities)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.entities, forKey: .entities)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case entities
    }
}