import Foundation

public struct ConversationRequest: Codable, Hashable, Sendable {
    /// Optional configurations for responses to this conversation
    public let responseConfig: ResponseConfig?
    /// The tags of the conversation. Used for filtering in Agent Designer.
    public let tags: JSONValue?
    /// Set of 16 key-value pairs that can be attached to an object. This can be useful for storing
    /// additional information about the object in a structured format, and querying for objects
    /// via API or the dashboard.
    /// 
    /// Keys are strings with a maximum length of 500 characters. Values are strings with a maximum
    /// length of 512 characters.
    /// 
    /// The metadata of the conversation supplied by the app which created the conversation.
    public let metadata: [String: String]?
    /// An externally supplied ID to uniquely identify this conversation
    public let conversationId: EntityIdBase
    /// Additional context used for simulation runs. When provided, this conversation will be treated as a simulation and
    /// may only be created by apps with the appropriate permission. Simulation conversations are excluded from normal
    /// search results unless explicitly included via the `simulationFilter` field.
    public let simulationContext: SimulationContext?
    /// The subject of the conversation
    public let subject: String?
    /// The url of the conversation
    public let url: String?
    /// The date and time the conversation was created
    public let createdAt: Date?
    /// The date and time the conversation was last updated
    public let updatedAt: Date?
    /// The messages in the conversation
    public let messages: [ConversationMessageRequest]
    /// The unique identifier of the conversation this new conversation was spawned from, if applicable.
    /// 
    /// Setting this also gives the new conversation access to the context it branched from: when the bot
    /// answers, the transcript of the spawned-from conversation (and of the conversations that one was
    /// spawned from, in turn) is merged into the prompt ahead of this conversation's own messages. Each
    /// ancestor is truncated at the point the spawn happened, so messages it receives afterwards are not
    /// included.
    /// 
    /// The referenced conversation must belong to the same agent. Because the merged transcript is read
    /// back to the end user, only set this to a conversation the current user is entitled to see.
    public let spawnedFromConversationId: EntityId?
    /// Who the conversation is for. Omit this field or send `allUsers` for a conversation that any of
    /// the agent's users may take part in. Send `users` to restrict the conversation to the listed users.
    /// A `USER` message from any other user, sent through `ask`, `askStream`, `appendNewMessages` or
    /// this request's `messages` when this request creates the conversation, is rejected with a 400.
    /// Initializing an existing conversation saves none of its `messages`.
    /// 
    /// The audience is set when the conversation is created and cannot be changed. Initializing an
    /// existing conversation leaves its audience unchanged.
    public let audience: ConversationAudience?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        responseConfig: ResponseConfig? = nil,
        tags: JSONValue? = nil,
        metadata: [String: String]? = nil,
        conversationId: EntityIdBase,
        simulationContext: SimulationContext? = nil,
        subject: String? = nil,
        url: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        messages: [ConversationMessageRequest],
        spawnedFromConversationId: EntityId? = nil,
        audience: ConversationAudience? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.responseConfig = responseConfig
        self.tags = tags
        self.metadata = metadata
        self.conversationId = conversationId
        self.simulationContext = simulationContext
        self.subject = subject
        self.url = url
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.messages = messages
        self.spawnedFromConversationId = spawnedFromConversationId
        self.audience = audience
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.responseConfig = try container.decodeIfPresent(ResponseConfig.self, forKey: .responseConfig)
        self.tags = try container.decodeIfPresent(JSONValue.self, forKey: .tags)
        self.metadata = try container.decodeIfPresent([String: String].self, forKey: .metadata)
        self.conversationId = try container.decode(EntityIdBase.self, forKey: .conversationId)
        self.simulationContext = try container.decodeIfPresent(SimulationContext.self, forKey: .simulationContext)
        self.subject = try container.decodeIfPresent(String.self, forKey: .subject)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.messages = try container.decode([ConversationMessageRequest].self, forKey: .messages)
        self.spawnedFromConversationId = try container.decodeIfPresent(EntityId.self, forKey: .spawnedFromConversationId)
        self.audience = try container.decodeIfPresent(ConversationAudience.self, forKey: .audience)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.responseConfig, forKey: .responseConfig)
        try container.encodeIfPresent(self.tags, forKey: .tags)
        try container.encodeIfPresent(self.metadata, forKey: .metadata)
        try container.encode(self.conversationId, forKey: .conversationId)
        try container.encodeIfPresent(self.simulationContext, forKey: .simulationContext)
        try container.encodeIfPresent(self.subject, forKey: .subject)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.createdAt, forKey: .createdAt)
        try container.encodeIfPresent(self.updatedAt, forKey: .updatedAt)
        try container.encode(self.messages, forKey: .messages)
        try container.encodeIfPresent(self.spawnedFromConversationId, forKey: .spawnedFromConversationId)
        try container.encodeIfPresent(self.audience, forKey: .audience)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case responseConfig
        case tags
        case metadata
        case conversationId
        case simulationContext
        case subject
        case url
        case createdAt
        case updatedAt
        case messages
        case spawnedFromConversationId
        case audience
    }
}