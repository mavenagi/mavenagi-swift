import Foundation

public struct NovelUserEvent: Codable, Hashable, Sendable {
    public let timestamp: Date?
    public let references: JSONValue?
    public let sourceInfo: SourceInfo?
    public let sessionInfo: SessionInfo?
    public let contextInfo: ContextInfo?
    /// The unique ID of the event
    public let id: EntityIdBase
    /// The name of the event
    public let eventName: UserEventName
    /// Information about the user who triggered the event
    public let userInfo: EventUserInfoBase
    /// Information about any feedback associated with the event
    public let feedbackInfo: [FeedbackInfo]?
    /// Information about the page on which the event occurred
    public let pageInfo: PageInfo?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        timestamp: Date? = nil,
        references: JSONValue? = nil,
        sourceInfo: SourceInfo? = nil,
        sessionInfo: SessionInfo? = nil,
        contextInfo: ContextInfo? = nil,
        id: EntityIdBase,
        eventName: UserEventName,
        userInfo: EventUserInfoBase,
        feedbackInfo: [FeedbackInfo]? = nil,
        pageInfo: PageInfo? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.timestamp = timestamp
        self.references = references
        self.sourceInfo = sourceInfo
        self.sessionInfo = sessionInfo
        self.contextInfo = contextInfo
        self.id = id
        self.eventName = eventName
        self.userInfo = userInfo
        self.feedbackInfo = feedbackInfo
        self.pageInfo = pageInfo
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timestamp = try container.decodeIfPresent(Date.self, forKey: .timestamp)
        self.references = try container.decodeIfPresent(JSONValue.self, forKey: .references)
        self.sourceInfo = try container.decodeIfPresent(SourceInfo.self, forKey: .sourceInfo)
        self.sessionInfo = try container.decodeIfPresent(SessionInfo.self, forKey: .sessionInfo)
        self.contextInfo = try container.decodeIfPresent(ContextInfo.self, forKey: .contextInfo)
        self.id = try container.decode(EntityIdBase.self, forKey: .id)
        self.eventName = try container.decode(UserEventName.self, forKey: .eventName)
        self.userInfo = try container.decode(EventUserInfoBase.self, forKey: .userInfo)
        self.feedbackInfo = try container.decodeIfPresent([FeedbackInfo].self, forKey: .feedbackInfo)
        self.pageInfo = try container.decodeIfPresent(PageInfo.self, forKey: .pageInfo)
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
        try container.encode(self.id, forKey: .id)
        try container.encode(self.eventName, forKey: .eventName)
        try container.encode(self.userInfo, forKey: .userInfo)
        try container.encodeIfPresent(self.feedbackInfo, forKey: .feedbackInfo)
        try container.encodeIfPresent(self.pageInfo, forKey: .pageInfo)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case timestamp
        case references
        case sourceInfo
        case sessionInfo
        case contextInfo
        case id
        case eventName
        case userInfo
        case feedbackInfo
        case pageInfo
    }
}