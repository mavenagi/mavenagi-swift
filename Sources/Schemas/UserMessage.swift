import Foundation

public struct UserMessage: Codable, Hashable, Sendable {
    /// ID that uniquely identifies the user that created this message
    public let userId: EntityIdBase
    /// The text of the message. Cannot be empty
    public let text: String
    public let userMessageType: UserConversationMessageType
    /// The date and time the conversation was created
    public let createdAt: Date?
    /// The date and time the conversation was last updated
    public let updatedAt: Date?
    /// The ID that uniquely identifies this message within the conversation
    public let conversationMessageId: EntityId
    /// The language of the message in ISO 639-1 code format
    public let language: String?
    /// The attachments associated with the message
    public let attachments: [AttachmentResponse]
    /// The ID of the agent user that created this message. More detail can be fetched via the agent user APIs. Will be empty only for legacy conversations.
    public let agentUserId: String?
    /// The display name of the user who created this message. Only available for users who have saved name information.
    public let userDisplayName: String?
    /// The delivery status of the message. Only applicable to messages sent via the deliverMessage API.
    /// All other messages have an `UNKNOWN` status.
    /// 
    /// * `SENT`: The message has been sent to the user.
    /// * `FAILED`: The message sending encountered an error.
    /// * `UNKNOWN`: The message status is unknown.
    public let status: MessageStatus
    /// Only present on newer messaged where `userMessageType` is `USER`.
    /// Indicates the state of the answer to the user message.
    /// 
    /// - `NOT_ASKED`: An answer was not requested for this user message.
    /// - `LLM_ENABLED`: An answer was requested for this user message and the LLM was enabled.
    /// - `LLM_DISABLED`: An answer was requested for this user message and the LLM was disabled.
    public let responseState: UserMessageResponseState?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        userId: EntityIdBase,
        text: String,
        userMessageType: UserConversationMessageType,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        conversationMessageId: EntityId,
        language: String? = nil,
        attachments: [AttachmentResponse],
        agentUserId: String? = nil,
        userDisplayName: String? = nil,
        status: MessageStatus,
        responseState: UserMessageResponseState? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.userId = userId
        self.text = text
        self.userMessageType = userMessageType
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.conversationMessageId = conversationMessageId
        self.language = language
        self.attachments = attachments
        self.agentUserId = agentUserId
        self.userDisplayName = userDisplayName
        self.status = status
        self.responseState = responseState
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(EntityIdBase.self, forKey: .userId)
        self.text = try container.decode(String.self, forKey: .text)
        self.userMessageType = try container.decode(UserConversationMessageType.self, forKey: .userMessageType)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.conversationMessageId = try container.decode(EntityId.self, forKey: .conversationMessageId)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.attachments = try container.decode([AttachmentResponse].self, forKey: .attachments)
        self.agentUserId = try container.decodeIfPresent(String.self, forKey: .agentUserId)
        self.userDisplayName = try container.decodeIfPresent(String.self, forKey: .userDisplayName)
        self.status = try container.decode(MessageStatus.self, forKey: .status)
        self.responseState = try container.decodeIfPresent(UserMessageResponseState.self, forKey: .responseState)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.text, forKey: .text)
        try container.encode(self.userMessageType, forKey: .userMessageType)
        try container.encodeIfPresent(self.createdAt, forKey: .createdAt)
        try container.encodeIfPresent(self.updatedAt, forKey: .updatedAt)
        try container.encode(self.conversationMessageId, forKey: .conversationMessageId)
        try container.encodeIfPresent(self.language, forKey: .language)
        try container.encode(self.attachments, forKey: .attachments)
        try container.encodeIfPresent(self.agentUserId, forKey: .agentUserId)
        try container.encodeIfPresent(self.userDisplayName, forKey: .userDisplayName)
        try container.encode(self.status, forKey: .status)
        try container.encodeIfPresent(self.responseState, forKey: .responseState)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case userId
        case text
        case userMessageType
        case createdAt
        case updatedAt
        case conversationMessageId
        case language
        case attachments
        case agentUserId
        case userDisplayName
        case status
        case responseState
    }
}