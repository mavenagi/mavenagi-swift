import Foundation

public struct ScopedEntity: Codable, Hashable, Sendable {
    public let entityId: EntityId
    public let scopeEntityId: EntityId?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        entityId: EntityId,
        scopeEntityId: EntityId? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.entityId = entityId
        self.scopeEntityId = scopeEntityId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.entityId = try container.decode(EntityId.self, forKey: .entityId)
        self.scopeEntityId = try container.decodeIfPresent(EntityId.self, forKey: .scopeEntityId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.entityId, forKey: .entityId)
        try container.encodeIfPresent(self.scopeEntityId, forKey: .scopeEntityId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case entityId
        case scopeEntityId
    }
}