import Foundation

public struct InboxItemCreateRequest: Codable, Hashable, Sendable {
    /// ID that uniquely identifies this inbox item
    public let inboxItemId: EntityIdBase
    /// Status of the inbox item.
    public let status: InboxItemStatus
    /// Severity of the inbox item.
    public let severity: InboxItemSeverity
    /// Additional metadata associated with the inbox item.
    public let metadata: [String: String]
    /// Title of the inbox item.
    public let title: String
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
        inboxItemId: EntityIdBase,
        status: InboxItemStatus,
        severity: InboxItemSeverity,
        metadata: [String: String],
        title: String,
        description: String? = nil,
        externalUrl: String? = nil,
        assignee: ScopedEntity? = nil,
        references: JSONValue? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.inboxItemId = inboxItemId
        self.status = status
        self.severity = severity
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
        self.inboxItemId = try container.decode(EntityIdBase.self, forKey: .inboxItemId)
        self.status = try container.decode(InboxItemStatus.self, forKey: .status)
        self.severity = try container.decode(InboxItemSeverity.self, forKey: .severity)
        self.metadata = try container.decode([String: String].self, forKey: .metadata)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.externalUrl = try container.decodeIfPresent(String.self, forKey: .externalUrl)
        self.assignee = try container.decodeIfPresent(ScopedEntity.self, forKey: .assignee)
        self.references = try container.decodeIfPresent(JSONValue.self, forKey: .references)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.inboxItemId, forKey: .inboxItemId)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.severity, forKey: .severity)
        try container.encode(self.metadata, forKey: .metadata)
        try container.encode(self.title, forKey: .title)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.externalUrl, forKey: .externalUrl)
        try container.encodeIfPresent(self.assignee, forKey: .assignee)
        try container.encodeIfPresent(self.references, forKey: .references)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case inboxItemId
        case status
        case severity
        case metadata
        case title
        case description
        case externalUrl
        case assignee
        case references
    }
}