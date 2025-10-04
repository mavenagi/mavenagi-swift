import Foundation

public enum EventResponse: Codable, Hashable, Sendable {
    case userEvent(UserEvent)
    case systemEvent(SystemEvent)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .eventType)
        switch discriminant {
        case "userEvent":
            self = .userEvent(try UserEvent(from: decoder))
        case "systemEvent":
            self = .systemEvent(try SystemEvent(from: decoder))
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown shape discriminant value: \(discriminant)"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws -> Void {
        switch self {
        case .userEvent(let data):
            try data.encode(to: encoder)
        case .systemEvent(let data):
            try data.encode(to: encoder)
        }
    }

    public struct UserEvent: Codable, Hashable, Sendable {
        public let eventType: String = "userEvent"
        public let timestamp: Date?
        public let references: JSONValue?
        public let sourceInfo: SourceInfo?
        public let sessionInfo: SessionInfo?
        public let contextInfo: ContextInfo?
        /// The unique ID of the event
        public let id: EntityId
        /// The name of the event
        public let eventName: UserEventName
        /// Information about the user who triggered the event
        public let userInfo: EventUserInfo
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
            id: EntityId,
            eventName: UserEventName,
            userInfo: EventUserInfo,
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
            self.id = try container.decode(EntityId.self, forKey: .id)
            self.eventName = try container.decode(UserEventName.self, forKey: .eventName)
            self.userInfo = try container.decode(EventUserInfo.self, forKey: .userInfo)
            self.feedbackInfo = try container.decodeIfPresent([FeedbackInfo].self, forKey: .feedbackInfo)
            self.pageInfo = try container.decodeIfPresent(PageInfo.self, forKey: .pageInfo)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventType, forKey: .eventType)
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
            case eventType
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

    public struct SystemEvent: Codable, Hashable, Sendable {
        public let eventType: String = "systemEvent"
        /// The name of the event
        public let eventName: SystemEventName
        public let timestamp: Date?
        public let references: JSONValue?
        public let sourceInfo: SourceInfo?
        public let sessionInfo: SessionInfo?
        public let contextInfo: ContextInfo?
        /// The unique ID of the event
        public let id: EntityId
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            eventName: SystemEventName,
            timestamp: Date? = nil,
            references: JSONValue? = nil,
            sourceInfo: SourceInfo? = nil,
            sessionInfo: SessionInfo? = nil,
            contextInfo: ContextInfo? = nil,
            id: EntityId,
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
            self.id = try container.decode(EntityId.self, forKey: .id)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventType, forKey: .eventType)
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
            case eventType
            case eventName
            case timestamp
            case references
            case sourceInfo
            case sessionInfo
            case contextInfo
            case id
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case eventType
    }
}