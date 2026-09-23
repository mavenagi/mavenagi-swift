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
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        page: Int? = nil,
        size: Int? = nil,
        sortDesc: Bool? = nil,
        parentIds: [EntityId],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.page = page
        self.size = size
        self.sortDesc = sortDesc
        self.parentIds = parentIds
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page)
        self.size = try container.decodeIfPresent(Int.self, forKey: .size)
        self.sortDesc = try container.decodeIfPresent(Bool.self, forKey: .sortDesc)
        self.parentIds = try container.decode([EntityId].self, forKey: .parentIds)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.page, forKey: .page)
        try container.encodeIfPresent(self.size, forKey: .size)
        try container.encodeIfPresent(self.sortDesc, forKey: .sortDesc)
        try container.encode(self.parentIds, forKey: .parentIds)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case page
        case size
        case sortDesc
        case parentIds
    }
}