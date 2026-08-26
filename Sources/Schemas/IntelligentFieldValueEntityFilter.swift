import Foundation

/// Filter by properties of the target entity
public struct IntelligentFieldValueEntityFilter: Codable, Hashable, Sendable {
    /// Filter to specific target entities by their entity IDs. OR semantics. Maximum 100 IDs.
    public let entityIds: [EntityId]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        entityIds: [EntityId]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.entityIds = entityIds
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.entityIds = try container.decodeIfPresent([EntityId].self, forKey: .entityIds)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.entityIds, forKey: .entityIds)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case entityIds
    }
}