import Foundation

public struct InboxItemCustom: Codable, Hashable, Sendable {
    /// Unique identifier for the inbox item.
    public let id: EntityId
    /// Timestamp when the inbox item was created.
    public let createdAt: Date
    /// Timestamp when the inbox item was last updated.
    public let updatedAt: Date
    /// Status of the inbox item.
    public let status: InboxItemStatus
    /// Severity of the inbox item.
    public let severity: InboxItemSeverity
    /// A set of tags associated with the inbox item that are used for filtering.
    public let tags: JSONValue?
    /// Additional metadata associated with the inbox item.
    public let metadata: [String: String]
    /// Title of the inbox item.
    public let title: String?
    /// Description of the inbox item.
    public let description: String?
    /// An optional URL that can be associated with the inbox item.
    public let externalUrl: String?
    /// An optional assignee for the inbox item.
    public let assignee: ScopedEntity?
    /// An optional list of references to other entities that are related to this inbox item.
    public let references: JSONValue?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: EntityId,
        createdAt: Date,
        updatedAt: Date,
        status: InboxItemStatus,
        severity: InboxItemSeverity,
        tags: JSONValue? = nil,
        metadata: [String: String],
        title: String? = nil,
        description: String? = nil,
        externalUrl: String? = nil,
        assignee: ScopedEntity? = nil,
        references: JSONValue? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.status = status
        self.severity = severity
        self.tags = tags
        self.metadata = metadata
        self.title = title
        self.description = description
        self.externalUrl = externalUrl
        self.assignee = assignee
        self.references = references
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(EntityId.self, forKey: .id)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.status = try container.decode(InboxItemStatus.self, forKey: .status)
        self.severity = try container.decode(InboxItemSeverity.self, forKey: .severity)
        self.tags = try container.decodeIfPresent(JSONValue.self, forKey: .tags)
        self.metadata = try container.decode([String: String].self, forKey: .metadata)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.externalUrl = try container.decodeIfPresent(String.self, forKey: .externalUrl)
        self.assignee = try container.decodeIfPresent(ScopedEntity.self, forKey: .assignee)
        self.references = try container.decodeIfPresent(JSONValue.self, forKey: .references)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.updatedAt, forKey: .updatedAt)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.severity, forKey: .severity)
        try container.encodeIfPresent(self.tags, forKey: .tags)
        try container.encode(self.metadata, forKey: .metadata)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.externalUrl, forKey: .externalUrl)
        try container.encodeIfPresent(self.assignee, forKey: .assignee)
        try container.encodeIfPresent(self.references, forKey: .references)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case createdAt
        case updatedAt
        case status
        case severity
        case tags
        case metadata
        case title
        case description
        case externalUrl
        case assignee
        case references
    }
}