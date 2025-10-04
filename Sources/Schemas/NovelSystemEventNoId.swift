import Foundation

public struct NovelSystemEventNoId: Codable, Hashable, Sendable {
    public let timestamp: Date?
    public let references: JSONValue?
    public let sourceInfo: SourceInfo?
    public let sessionInfo: SessionInfo?
    public let contextInfo: ContextInfo?
    /// The name of the event
    public let eventName: SystemEventName
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        timestamp: Date? = nil,
        references: JSONValue? = nil,
        sourceInfo: SourceInfo? = nil,
        sessionInfo: SessionInfo? = nil,
        contextInfo: ContextInfo? = nil,
        eventName: SystemEventName,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.timestamp = timestamp
        self.references = references
        self.sourceInfo = sourceInfo
        self.sessionInfo = sessionInfo
        self.contextInfo = contextInfo
        self.eventName = eventName
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timestamp = try container.decodeIfPresent(Date.self, forKey: .timestamp)
        self.references = try container.decodeIfPresent(JSONValue.self, forKey: .references)
        self.sourceInfo = try container.decodeIfPresent(SourceInfo.self, forKey: .sourceInfo)
        self.sessionInfo = try container.decodeIfPresent(SessionInfo.self, forKey: .sessionInfo)
        self.contextInfo = try container.decodeIfPresent(ContextInfo.self, forKey: .contextInfo)
        self.eventName = try container.decode(SystemEventName.self, forKey: .eventName)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        try container.encodeIfPresent(self.references, forKey: .references)
        try container.encodeIfPresent(self.sourceInfo, forKey: .sourceInfo)
        try container.encodeIfPresent(self.sessionInfo, forKey: .sessionInfo)
        try container.encodeIfPresent(self.contextInfo, forKey: .contextInfo)
        try container.encode(self.eventName, forKey: .eventName)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case timestamp
        case references
        case sourceInfo
        case sessionInfo
        case contextInfo
        case eventName
    }
}