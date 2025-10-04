import Foundation

public struct ConversationRequest: Codable, Hashable, Sendable {
    /// An externally supplied ID to uniquely identify this conversation
    public let conversationId: EntityIdBase
    /// Additional context used for simulation runs. When provided, this conversation will be treated as a simulation and
    /// may only be created by apps with the appropriate permission. Simulation conversations are excluded from normal
    /// search results unless explicitly included via the `simulationFilter` field.
    public let simulationContext: SimulationContext?
    /// Optional configurations for responses to this conversation
    public let responseConfig: ResponseConfig?
    /// The subject of the conversation
    public let subject: String?
    /// The url of the conversation
    public let url: String?
    /// The date and time the conversation was created
    public let createdAt: Date?
    /// The date and time the conversation was last updated
    public let updatedAt: Date?
    /// The tags of the conversation. Used for filtering in Agent Designer.
    public let tags: JSONValue?
    /// The metadata of the conversation supplied by the app which created the conversation.
    public let metadata: [String: String]?
    /// The messages in the conversation
    public let messages: [ConversationMessageRequest]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        conversationId: EntityIdBase,
        simulationContext: SimulationContext? = nil,
        responseConfig: ResponseConfig? = nil,
        subject: String? = nil,
        url: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        tags: JSONValue? = nil,
        metadata: [String: String]? = nil,
        messages: [ConversationMessageRequest],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.conversationId = conversationId
        self.simulationContext = simulationContext
        self.responseConfig = responseConfig
        self.subject = subject
        self.url = url
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.tags = tags
        self.metadata = metadata
        self.messages = messages
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.conversationId = try container.decode(EntityIdBase.self, forKey: .conversationId)
        self.simulationContext = try container.decodeIfPresent(SimulationContext.self, forKey: .simulationContext)
        self.responseConfig = try container.decodeIfPresent(ResponseConfig.self, forKey: .responseConfig)
        self.subject = try container.decodeIfPresent(String.self, forKey: .subject)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.tags = try container.decodeIfPresent(JSONValue.self, forKey: .tags)
        self.metadata = try container.decodeIfPresent([String: String].self, forKey: .metadata)
        self.messages = try container.decode([ConversationMessageRequest].self, forKey: .messages)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.conversationId, forKey: .conversationId)
        try container.encodeIfPresent(self.simulationContext, forKey: .simulationContext)
        try container.encodeIfPresent(self.responseConfig, forKey: .responseConfig)
        try container.encodeIfPresent(self.subject, forKey: .subject)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.createdAt, forKey: .createdAt)
        try container.encodeIfPresent(self.updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(self.tags, forKey: .tags)
        try container.encodeIfPresent(self.metadata, forKey: .metadata)
        try container.encode(self.messages, forKey: .messages)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationId
        case simulationContext
        case responseConfig
        case subject
        case url
        case createdAt
        case updatedAt
        case tags
        case metadata
        case messages
    }
}