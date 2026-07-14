import Foundation

public struct ConversationMessageRequest: Codable, Hashable, Sendable {
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