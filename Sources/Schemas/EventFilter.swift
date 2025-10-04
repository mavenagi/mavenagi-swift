import Foundation

public struct EventFilter: Codable, Hashable, Sendable {
    public let search: String?
    public let createdAfter: Date?
    public let createdBefore: Date?
    public let references: [ScopedEntity]?
    public let eventTypes: [EventType]?
    public let userEventNames: [UserEventName]?
    public let systemEventNames: [SystemEventName]?
    public let agentUserIds: [String]?
    public let legacyFeedbackTypes: [FeedbackType]?
    public let hasEventText: Bool?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        search: String? = nil,
        createdAfter: Date? = nil,
        createdBefore: Date? = nil,
        references: [ScopedEntity]? = nil,
        eventTypes: [EventType]? = nil,
        userEventNames: [UserEventName]? = nil,
        systemEventNames: [SystemEventName]? = nil,
        agentUserIds: [String]? = nil,
        legacyFeedbackTypes: [FeedbackType]? = nil,
        hasEventText: Bool? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.search = search
        self.createdAfter = createdAfter
        self.createdBefore = createdBefore
        self.references = references
        self.eventTypes = eventTypes
        self.userEventNames = userEventNames
        self.systemEventNames = systemEventNames
        self.agentUserIds = agentUserIds
        self.legacyFeedbackTypes = legacyFeedbackTypes
        self.hasEventText = hasEventText
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.search = try container.decodeIfPresent(String.self, forKey: .search)
        self.createdAfter = try container.decodeIfPresent(Date.self, forKey: .createdAfter)
        self.createdBefore = try container.decodeIfPresent(Date.self, forKey: .createdBefore)
        self.references = try container.decodeIfPresent([ScopedEntity].self, forKey: .references)
        self.eventTypes = try container.decodeIfPresent([EventType].self, forKey: .eventTypes)
        self.userEventNames = try container.decodeIfPresent([UserEventName].self, forKey: .userEventNames)
        self.systemEventNames = try container.decodeIfPresent([SystemEventName].self, forKey: .systemEventNames)
        self.agentUserIds = try container.decodeIfPresent([String].self, forKey: .agentUserIds)
        self.legacyFeedbackTypes = try container.decodeIfPresent([FeedbackType].self, forKey: .legacyFeedbackTypes)
        self.hasEventText = try container.decodeIfPresent(Bool.self, forKey: .hasEventText)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.search, forKey: .search)
        try container.encodeIfPresent(self.createdAfter, forKey: .createdAfter)
        try container.encodeIfPresent(self.createdBefore, forKey: .createdBefore)
        try container.encodeIfPresent(self.references, forKey: .references)
        try container.encodeIfPresent(self.eventTypes, forKey: .eventTypes)
        try container.encodeIfPresent(self.userEventNames, forKey: .userEventNames)
        try container.encodeIfPresent(self.systemEventNames, forKey: .systemEventNames)
        try container.encodeIfPresent(self.agentUserIds, forKey: .agentUserIds)
        try container.encodeIfPresent(self.legacyFeedbackTypes, forKey: .legacyFeedbackTypes)
        try container.encodeIfPresent(self.hasEventText, forKey: .hasEventText)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case search
        case createdAfter
        case createdBefore
        case references
        case eventTypes
        case userEventNames
        case systemEventNames
        case agentUserIds
        case legacyFeedbackTypes
        case hasEventText
    }
}