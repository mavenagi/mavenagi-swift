import Foundation

public enum DeliverContent: Codable, Hashable, Sendable {
    /// Has the agent take a `WELCOME` or `PROACTIVE` turn on the conversation, and delivers the agent's
    /// reply to the app that owns it. `text` steers what the agent says. The `text` is saved on the
    /// conversation but not delivered; only the agent's reply is. Returns a 400 if the conversation has
    /// `llmEnabled` set to false.
    case ask(Ask)
    /// A message to deliver as written, such as a human agent's reply. The agent does not respond to it.
    case message(Message)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .contentType)
        switch discriminant {
        case "ask":
            self = .ask(try Ask(from: decoder))
        case "message":
            self = .message(try Message(from: decoder))
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
        case .ask(let data):
            try data.encode(to: encoder)
        case .message(let data):
            try data.encode(to: encoder)
        }
    }

    /// A message to deliver as written, such as a human agent's reply. The agent does not respond to it.
    public struct Message: Codable, Hashable, Sendable {
        public let contentType: String = "message"
        /// ID that uniquely identifies the user that created this message
        public let userId: EntityIdBase
        /// The text of the message. Cannot be empty
        public let text: String
        public let userMessageType: UserConversationMessageType
        /// The date and time the conversation was created
        public let createdAt: Date?
        /// The date and time the conversation was last updated
        public let updatedAt: Date?
        /// Key-value metadata for this message, supplied by the app which created the message.
        /// Useful for storing additional structured information about the message and querying
        /// for it via API or the dashboard.
        /// 
        /// Keys are strings with a maximum length of 500 characters. Values are strings with a
        /// maximum length of 500 characters.
        public let appMetadata: [String: String]?
        /// The ID that uniquely identifies this message within the conversation
        public let conversationMessageId: EntityIdBase
        /// The attachments to the message.
        public let attachments: [AttachmentRequest]?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            userId: EntityIdBase,
            text: String,
            userMessageType: UserConversationMessageType,
            createdAt: Date? = nil,
            updatedAt: Date? = nil,
            appMetadata: [String: String]? = nil,
            conversationMessageId: EntityIdBase,
            attachments: [AttachmentRequest]? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.userId = userId
            self.text = text
            self.userMessageType = userMessageType
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.appMetadata = appMetadata
            self.conversationMessageId = conversationMessageId
            self.attachments = attachments
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.userId = try container.decode(EntityIdBase.self, forKey: .userId)
            self.text = try container.decode(String.self, forKey: .text)
            self.userMessageType = try container.decode(UserConversationMessageType.self, forKey: .userMessageType)
            self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
            self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
            self.appMetadata = try container.decodeIfPresent([String: String].self, forKey: .appMetadata)
            self.conversationMessageId = try container.decode(EntityIdBase.self, forKey: .conversationMessageId)
            self.attachments = try container.decodeIfPresent([AttachmentRequest].self, forKey: .attachments)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.contentType, forKey: .contentType)
            try container.encode(self.userId, forKey: .userId)
            try container.encode(self.text, forKey: .text)
            try container.encode(self.userMessageType, forKey: .userMessageType)
            try container.encodeIfPresent(self.createdAt, forKey: .createdAt)
            try container.encodeIfPresent(self.updatedAt, forKey: .updatedAt)
            try container.encodeIfPresent(self.appMetadata, forKey: .appMetadata)
            try container.encode(self.conversationMessageId, forKey: .conversationMessageId)
            try container.encodeIfPresent(self.attachments, forKey: .attachments)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case contentType
            case userId
            case text
            case userMessageType
            case createdAt
            case updatedAt
            case appMetadata
            case conversationMessageId
            case attachments
        }
    }

    /// Has the agent take a `WELCOME` or `PROACTIVE` turn on the conversation, and delivers the agent's
    /// reply to the app that owns it. `text` steers what the agent says. The `text` is saved on the
    /// conversation but not delivered; only the agent's reply is. Returns a 400 if the conversation has
    /// `llmEnabled` set to false.
    public struct Ask: Codable, Hashable, Sendable {
        public let contentType: String = "ask"
        /// Externally supplied ID to uniquely identify this message within the conversation. If a message with this ID already exists it will be reused and will not be updated.
        public let conversationMessageId: EntityIdBase
        /// What prompts this assistant response. Omit (or send USER_MESSAGE) for a normal user
        /// question — this is the backwards-compatible default. Use WELCOME for an agent-authored
        /// opener, or PROACTIVE for a message the user did not prompt.
        public let type: AskType?
        /// For USER_MESSAGE (the default) this is the user's message, in the user's own words, and
        /// is required. For WELCOME and PROACTIVE it is optional and, when provided, steers the
        /// agent's response (a directive to the agent, not the user's own words). (Changed from
        /// required to optional to support the non-user ask types — existing USER_MESSAGE callers
        /// are unaffected.)
        public let text: String?
        /// The attachments to the message. Image attachments will be sent to the LLM as additional data.
        /// Non-image attachments can be stored and downloaded from the API but will not be sent to the LLM.
        public let attachments: [AttachmentRequest]?
        /// Transient data which the Maven platform will not persist. This data will only be forwarded to actions taken by this ask request. For example, one may put in user tokens as transient data.
        public let transientData: [String: String]?
        /// IANA timezone identifier (e.g. "America/New_York", "Europe/London") to be used for time-based operations in the conversation.
        public let timezone: String?
        /// Key-value metadata to persist on the user message created by this request. Unlike
        /// `transientData` (which is never persisted) this is stored and returned when the message
        /// is read back via the API or dashboard, and unlike user data it is not sent to the LLM.
        /// Applied only when the message is first created — if `conversationMessageId` already
        /// exists the message is reused and its metadata is not updated. Keys and values are strings
        /// with a maximum length of 500 characters each.
        public let appMetadata: [String: String]?
        /// Externally supplied ID to uniquely identify the user that created this message
        public let userId: EntityIdBase
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            conversationMessageId: EntityIdBase,
            type: AskType? = nil,
            text: String? = nil,
            attachments: [AttachmentRequest]? = nil,
            transientData: [String: String]? = nil,
            timezone: String? = nil,
            appMetadata: [String: String]? = nil,
            userId: EntityIdBase,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.conversationMessageId = conversationMessageId
            self.type = type
            self.text = text
            self.attachments = attachments
            self.transientData = transientData
            self.timezone = timezone
            self.appMetadata = appMetadata
            self.userId = userId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.conversationMessageId = try container.decode(EntityIdBase.self, forKey: .conversationMessageId)
            self.type = try container.decodeIfPresent(AskType.self, forKey: .type)
            self.text = try container.decodeIfPresent(String.self, forKey: .text)
            self.attachments = try container.decodeIfPresent([AttachmentRequest].self, forKey: .attachments)
            self.transientData = try container.decodeIfPresent([String: String].self, forKey: .transientData)
            self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
            self.appMetadata = try container.decodeIfPresent([String: String].self, forKey: .appMetadata)
            self.userId = try container.decode(EntityIdBase.self, forKey: .userId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.contentType, forKey: .contentType)
            try container.encode(self.conversationMessageId, forKey: .conversationMessageId)
            try container.encodeIfPresent(self.type, forKey: .type)
            try container.encodeIfPresent(self.text, forKey: .text)
            try container.encodeIfPresent(self.attachments, forKey: .attachments)
            try container.encodeIfPresent(self.transientData, forKey: .transientData)
            try container.encodeIfPresent(self.timezone, forKey: .timezone)
            try container.encodeIfPresent(self.appMetadata, forKey: .appMetadata)
            try container.encode(self.userId, forKey: .userId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case contentType
            case conversationMessageId
            case type
            case text
            case attachments
            case transientData
            case timezone
            case appMetadata
            case userId
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case contentType
    }
}