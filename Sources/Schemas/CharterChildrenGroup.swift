import Foundation

public struct CharterChildrenGroup: Codable, Hashable, Sendable {
    /// The parent whose children are listed. Null for root charters (when parentIds was empty).
    public let parentId: Nullable<EntityId>
    /// Direct children ordered by userRank ASC, updatedAt DESC.
    /// childCharterIds on each child is fully populated — use childCharterIds.length > 0
    /// to determine whether the node has children to expand.
    public let children: [CharterResponse]
    /// True if this group's children were truncated by the page limit. Only
    /// one group (the last non-empty group) in a response can have
    /// hasMore=true; all preceding groups are guaranteed complete. Fetch the
    /// next page with the same parentIds to retrieve remaining children.
    public let hasMore: Bool
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        parentId: Nullable<EntityId>,
        children: [CharterResponse],
        hasMore: Bool,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.parentId = parentId
        self.children = children
        self.hasMore = hasMore
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.parentId = try container.decode(Nullable<EntityId>.self, forKey: .parentId)
        self.children = try container.decode([CharterResponse].self, forKey: .children)
        self.hasMore = try container.decode(Bool.self, forKey: .hasMore)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.parentId, forKey: .parentId)
        try container.encode(self.children, forKey: .children)
        try container.encode(self.hasMore, forKey: .hasMore)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case parentId
        case children
        case hasMore
    }
}