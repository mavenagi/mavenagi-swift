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
    /// Additional metadata associated with the inbox item.
    public let metadata: [String: String]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: EntityId,
        createdAt: Date,
        updatedAt: Date,
        status: InboxItemStatus,
        severity: InboxItemSeverity,
        metadata: [String: String],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.status = status
        self.severity = severity
        self.metadata = metadata
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(EntityId.self, forKey: .id)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.status = try container.decode(InboxItemStatus.self, forKey: .status)
        self.severity = try container.decode(InboxItemSeverity.self, forKey: .severity)
        self.metadata = try container.decode([String: String].self, forKey: .metadata)
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
        try container.encode(self.metadata, forKey: .metadata)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case createdAt
        case updatedAt
        case status
        case severity
        case metadata
    }
}