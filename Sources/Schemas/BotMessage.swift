import Foundation

public struct BotMessage: Codable, Hashable, Sendable {
    /// The date and time the conversation was created
    public let createdAt: Date?
    /// The date and time the conversation was last updated
    public let updatedAt: Date?
    /// The ID that uniquely identifies this message within the conversation
    public let conversationMessageId: EntityId
    public let botMessageType: BotConversationMessageType
    public let responses: [BotResponse]
    public let metadata: BotResponseMetadata
    public let status: MessageStatus
    /// The logic that was used to generate the response. Response size may be large; only present on the getConversation request.
    public let logic: BotLogic?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        conversationMessageId: EntityId,
        botMessageType: BotConversationMessageType,
        responses: [BotResponse],
        metadata: BotResponseMetadata,
        status: MessageStatus,
        logic: BotLogic? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.conversationMessageId = conversationMessageId
        self.botMessageType = botMessageType
        self.responses = responses
        self.metadata = metadata
        self.status = status
        self.logic = logic
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.conversationMessageId = try container.decode(EntityId.self, forKey: .conversationMessageId)
        self.botMessageType = try container.decode(BotConversationMessageType.self, forKey: .botMessageType)
        self.responses = try container.decode([BotResponse].self, forKey: .responses)
        self.metadata = try container.decode(BotResponseMetadata.self, forKey: .metadata)
        self.status = try container.decode(MessageStatus.self, forKey: .status)
        self.logic = try container.decodeIfPresent(BotLogic.self, forKey: .logic)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.createdAt, forKey: .createdAt)
        try container.encodeIfPresent(self.updatedAt, forKey: .updatedAt)
        try container.encode(self.conversationMessageId, forKey: .conversationMessageId)
        try container.encode(self.botMessageType, forKey: .botMessageType)
        try container.encode(self.responses, forKey: .responses)
        try container.encode(self.metadata, forKey: .metadata)
        try container.encode(self.status, forKey: .status)
        try container.encodeIfPresent(self.logic, forKey: .logic)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case createdAt
        case updatedAt
        case conversationMessageId
        case botMessageType
        case responses
        case metadata
        case status
        case logic
    }
}