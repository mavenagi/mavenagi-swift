import Foundation

public struct InboxFilter: Codable, Hashable, Sendable {
    /// List of inbox item statuses to filter by.
    public let statuses: [InboxItemStatus]?
    /// List of inbox item types to filter by.
    public let type: [InboxItemType]?
    /// Filter for items that have at least one of these tags.
    public let tags: JSONValue?
    /// Filter for items created after this timestamp.
    public let createdAfter: Date?
    /// Filter for items created before this timestamp.
    public let createdBefore: Date?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        statuses: [InboxItemStatus]? = nil,
        type: [InboxItemType]? = nil,
        tags: JSONValue? = nil,
        createdAfter: Date? = nil,
        createdBefore: Date? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.statuses = statuses
        self.type = type
        self.tags = tags
        self.createdAfter = createdAfter
        self.createdBefore = createdBefore
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.statuses = try container.decodeIfPresent([InboxItemStatus].self, forKey: .statuses)
        self.type = try container.decodeIfPresent([InboxItemType].self, forKey: .type)
        self.tags = try container.decodeIfPresent(JSONValue.self, forKey: .tags)
        self.createdAfter = try container.decodeIfPresent(Date.self, forKey: .createdAfter)
        self.createdBefore = try container.decodeIfPresent(Date.self, forKey: .createdBefore)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.statuses, forKey: .statuses)
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.tags, forKey: .tags)
        try container.encodeIfPresent(self.createdAfter, forKey: .createdAfter)
        try container.encodeIfPresent(self.createdBefore, forKey: .createdBefore)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case statuses
        case type
        case tags
        case createdAfter
        case createdBefore
    }
}