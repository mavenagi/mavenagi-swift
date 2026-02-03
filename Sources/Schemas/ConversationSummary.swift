import Foundation

public struct ConversationSummary: Codable, Hashable, Sendable {
    /// The IDs of the actions that were taken by Maven in the conversation
    public let actionIds: [EntityIdWithoutAgent]
    /// The IDs of the actions that were taken by Maven but not completed in the conversation. Occurs when the user is shown an action form but does not submit it.
    public let incompleteActionIds: [EntityIdWithoutAgent]
    /// The number of insert events on messages in the conversation.
    public let insertCount: Int
    /// The number of thumbs up events on messages in the conversation.
    public let thumbsUpCount: Int
    /// The number of thumbs down events on messages in the conversation.
    public let thumbsDownCount: Int
    /// The number of bot response messages that failed and returned the Agent's system fallback message.
    public let handoffCount: Int
    /// The number of messages of type `USER` in the conversation.
    public let userMessageCount: Int
    /// The number of bot answer messages in the conversation.
    public let botMessageCount: Int
    /// The CSAT score for the conversation
    public let csat: Double?
    /// The total time in milliseconds that the user spent interacting with the conversation.
    /// Calculated by taking the timestamp of the last message in the conversation minus the timestamp of the first message.
    public let handleTime: Int64?
    /// The time in milliseconds that elapsed before a human agent responded to the conversation.
    /// Calculated by taking the timestamp of the first message of type `HUMAN_AGENT`
    /// minus the timestamp of the first message in the conversation.
    /// 
    /// Will not be provided if the conversation does not have a message of type `HUMAN_AGENT`.
    public let humanAgentResponseDelay: Int64?
    /// The names of all users that have a message of type `HUMAN_AGENT` on the conversation.
    public let humanAgents: [String]
    /// The names of all users that have an associated insert event on the conversation.
    public let humanAgentsWithInserts: [String]
    /// The names of all users that have a message of type `USER` on the conversation.
    public let users: [String]
    /// The user identifiers (typically email addresses or phone numbers) of all users that have a message of type `USER` on the conversation.
    public let userIdentifiers: [String]
    /// The text of the last user message in the conversation.
    public let lastUserMessage: String?
    /// The text of the last bot message in the conversation.
    public let lastBotMessage: String?
    /// The set of app IDs that are involved in this conversation. This includes:
    /// - The app ID that created the conversation
    /// - The app IDs of all messages created in the conversation
    /// - The app IDs of all actions selected by the LLM in the conversation (including unsubmitted forms)
    /// - The app IDs of all documents referenced by LLM responses in the conversation (does not include document search results not utilized by the LLM)
    public let involvedAppIds: JSONValue
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        actionIds: [EntityIdWithoutAgent],
        incompleteActionIds: [EntityIdWithoutAgent],
        insertCount: Int,
        thumbsUpCount: Int,
        thumbsDownCount: Int,
        handoffCount: Int,
        userMessageCount: Int,
        botMessageCount: Int,
        csat: Double? = nil,
        handleTime: Int64? = nil,
        humanAgentResponseDelay: Int64? = nil,
        humanAgents: [String],
        humanAgentsWithInserts: [String],
        users: [String],
        userIdentifiers: [String],
        lastUserMessage: String? = nil,
        lastBotMessage: String? = nil,
        involvedAppIds: JSONValue,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.actionIds = actionIds
        self.incompleteActionIds = incompleteActionIds
        self.insertCount = insertCount
        self.thumbsUpCount = thumbsUpCount
        self.thumbsDownCount = thumbsDownCount
        self.handoffCount = handoffCount
        self.userMessageCount = userMessageCount
        self.botMessageCount = botMessageCount
        self.csat = csat
        self.handleTime = handleTime
        self.humanAgentResponseDelay = humanAgentResponseDelay
        self.humanAgents = humanAgents
        self.humanAgentsWithInserts = humanAgentsWithInserts
        self.users = users
        self.userIdentifiers = userIdentifiers
        self.lastUserMessage = lastUserMessage
        self.lastBotMessage = lastBotMessage
        self.involvedAppIds = involvedAppIds
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.actionIds = try container.decode([EntityIdWithoutAgent].self, forKey: .actionIds)
        self.incompleteActionIds = try container.decode([EntityIdWithoutAgent].self, forKey: .incompleteActionIds)
        self.insertCount = try container.decode(Int.self, forKey: .insertCount)
        self.thumbsUpCount = try container.decode(Int.self, forKey: .thumbsUpCount)
        self.thumbsDownCount = try container.decode(Int.self, forKey: .thumbsDownCount)
        self.handoffCount = try container.decode(Int.self, forKey: .handoffCount)
        self.userMessageCount = try container.decode(Int.self, forKey: .userMessageCount)
        self.botMessageCount = try container.decode(Int.self, forKey: .botMessageCount)
        self.csat = try container.decodeIfPresent(Double.self, forKey: .csat)
        self.handleTime = try container.decodeIfPresent(Int64.self, forKey: .handleTime)
        self.humanAgentResponseDelay = try container.decodeIfPresent(Int64.self, forKey: .humanAgentResponseDelay)
        self.humanAgents = try container.decode([String].self, forKey: .humanAgents)
        self.humanAgentsWithInserts = try container.decode([String].self, forKey: .humanAgentsWithInserts)
        self.users = try container.decode([String].self, forKey: .users)
        self.userIdentifiers = try container.decode([String].self, forKey: .userIdentifiers)
        self.lastUserMessage = try container.decodeIfPresent(String.self, forKey: .lastUserMessage)
        self.lastBotMessage = try container.decodeIfPresent(String.self, forKey: .lastBotMessage)
        self.involvedAppIds = try container.decode(JSONValue.self, forKey: .involvedAppIds)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.actionIds, forKey: .actionIds)
        try container.encode(self.incompleteActionIds, forKey: .incompleteActionIds)
        try container.encode(self.insertCount, forKey: .insertCount)
        try container.encode(self.thumbsUpCount, forKey: .thumbsUpCount)
        try container.encode(self.thumbsDownCount, forKey: .thumbsDownCount)
        try container.encode(self.handoffCount, forKey: .handoffCount)
        try container.encode(self.userMessageCount, forKey: .userMessageCount)
        try container.encode(self.botMessageCount, forKey: .botMessageCount)
        try container.encodeIfPresent(self.csat, forKey: .csat)
        try container.encodeIfPresent(self.handleTime, forKey: .handleTime)
        try container.encodeIfPresent(self.humanAgentResponseDelay, forKey: .humanAgentResponseDelay)
        try container.encode(self.humanAgents, forKey: .humanAgents)
        try container.encode(self.humanAgentsWithInserts, forKey: .humanAgentsWithInserts)
        try container.encode(self.users, forKey: .users)
        try container.encode(self.userIdentifiers, forKey: .userIdentifiers)
        try container.encodeIfPresent(self.lastUserMessage, forKey: .lastUserMessage)
        try container.encodeIfPresent(self.lastBotMessage, forKey: .lastBotMessage)
        try container.encode(self.involvedAppIds, forKey: .involvedAppIds)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case actionIds
        case incompleteActionIds
        case insertCount
        case thumbsUpCount
        case thumbsDownCount
        case handoffCount
        case userMessageCount
        case botMessageCount
        case csat
        case handleTime
        case humanAgentResponseDelay
        case humanAgents
        case humanAgentsWithInserts
        case users
        case userIdentifiers
        case lastUserMessage
        case lastBotMessage
        case involvedAppIds
    }
}