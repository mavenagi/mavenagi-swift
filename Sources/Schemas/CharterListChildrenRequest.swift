import Foundation

/// Note: sortDesc is ignored — results are always ordered by userRank ASC,
/// updatedAt DESC within each group.
public struct CharterListChildrenRequest: Codable, Hashable, Sendable {
    /// Page number to return, defaults to 0
    public let page: Int?
    /// The size of the page to return, defaults to 20. Max 1000.
    public let size: Int?
    /// Whether to sort descending, defaults to true
    public let sortDesc: Bool?
    /// Parents whose direct children to return. Pass an empty list to fetch root
    /// charters for the agent. Roots and specific parents cannot be mixed in one request.
    /// Maximum 50 parent IDs per request.
    public let parentIds: [EntityId]
    /// List the charters as this agent variant sees them, parents and children alike. Its staged
    /// edits are included: a charter with a staged edit is read at that edit, a charter created
    /// in the variant is included, and a charter deleted in the variant, whether the delete is
    /// staged or already in its snapshot, is left out; naming one as a parent is rejected with a
    /// 400. A parent the variant doesn't carry has no children. If not provided, the request is rejected with `VARIANT_REQUIRED` while charters
    /// are versioned for the agent, and otherwise reads through the agent's single variant, as
    /// its snapshot has it, or the published charters while variant reads are off.
    public let variantId: EntityIdWithoutAgent?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        page: Int? = nil,
        size: Int? = nil,
        sortDesc: Bool? = nil,
        parentIds: [EntityId],
        variantId: EntityIdWithoutAgent? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.page = page
        self.size = size
        self.sortDesc = sortDesc
        self.parentIds = parentIds
        self.variantId = variantId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page)
        self.size = try container.decodeIfPresent(Int.self, forKey: .size)
        self.sortDesc = try container.decodeIfPresent(Bool.self, forKey: .sortDesc)
        self.parentIds = try container.decode([EntityId].self, forKey: .parentIds)
        self.variantId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .variantId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.page, forKey: .page)
        try container.encodeIfPresent(self.size, forKey: .size)
        try container.encodeIfPresent(self.sortDesc, forKey: .sortDesc)
        try container.encode(self.parentIds, forKey: .parentIds)
        try container.encodeIfPresent(self.variantId, forKey: .variantId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case page
        case size
        case sortDesc
        case parentIds
        case variantId
    }
}