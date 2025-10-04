import Foundation

public struct NovelSystemEvent: Codable, Hashable, Sendable {
    /// The name of the event
    public let eventName: SystemEventName
    public let timestamp: Date?
    public let references: JSONValue?
    public let sourceInfo: SourceInfo?
    public let sessionInfo: SessionInfo?
    public let contextInfo: ContextInfo?
    /// The unique ID of the event
    public let id: EntityIdBase
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        eventName: SystemEventName,
        timestamp: Date? = nil,
        references: JSONValue? = nil,
        sourceInfo: SourceInfo? = nil,
        sessionInfo: SessionInfo? = nil,
        contextInfo: ContextInfo? = nil,
        id: EntityIdBase,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.eventName = eventName
        self.timestamp = timestamp
        self.references = references
        self.sourceInfo = sourceInfo
        self.sessionInfo = sessionInfo
        self.contextInfo = contextInfo
        self.id = id
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventName = try container.decode(SystemEventName.self, forKey: .eventName)
        self.timestamp = try container.decodeIfPresent(Date.self, forKey: .timestamp)
        self.references = try container.decodeIfPresent(JSONValue.self, forKey: .references)
        self.sourceInfo = try container.decodeIfPresent(SourceInfo.self, forKey: .sourceInfo)
        self.sessionInfo = try container.decodeIfPresent(SessionInfo.self, forKey: .sessionInfo)
        self.contextInfo = try container.decodeIfPresent(ContextInfo.self, forKey: .contextInfo)
        self.id = try container.decode(EntityIdBase.self, forKey: .id)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.eventName, forKey: .eventName)
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        try container.encodeIfPresent(self.references, forKey: .references)
        try container.encodeIfPresent(self.sourceInfo, forKey: .sourceInfo)
        try container.encodeIfPresent(self.sessionInfo, forKey: .sessionInfo)
        try container.encodeIfPresent(self.contextInfo, forKey: .contextInfo)
        try container.encode(self.id, forKey: .id)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case eventName
        case timestamp
        case references
        case sourceInfo
        case sessionInfo
        case contextInfo
        case id
    }
}