import Foundation

public struct ConversationFilter: Codable, Hashable, Sendable {
    /// Full-text search query for matching conversations by content. 
    /// When you search with this parameter, you're performing a full-text search across all textual content 
    /// in the conversations, including both the user's messages and the AI's responses.
    /// 
    /// This field also supports a syntax for advanced filtering the `metadata` and `tags` fields.           
    /// 
    /// Metadata examples:
    /// - `metadata:myvalue` - matches conversations with any metadata field set to `myvalue`
    /// - `metadata.mykey:myvalue` - matches conversations with a metadata field `mykey` set to `myvalue`
    /// - `metadata.mykey:myvalue OR anothervalue` - matches conversations with a metadata field `mykey` set to `myvalue` or `anothervalue`
    /// - `metadata.mykey:*` - matches conversations with a metadata field `mykey`
    /// - `-metadata:myvalue` - matches conversations that do not have any metadata field set to `myvalue`
    /// - `_exists_:metadata` - matches conversations that have any metadata field set
    /// 
    /// Tags examples:
    /// - `tags:myvalue` - matches conversations with a tag of `myvalue`
    /// - `tags:myvalue OR anothervalue` - matches conversations with a tag of `myvalue` or `anothervalue`
    /// - `-tags:myvalue` - matches conversations that do not have the tag `myvalue`
    /// - `_exists_:tags` - matches conversations that have any tags field set
    public let search: String?
    /// Filter conversations created on or after this timestamp
    public let createdAfter: Date?
    /// Filter conversations created on or before this timestamp
    public let createdBefore: Date?
    /// Filter by app IDs
    public let apps: [String]?
    /// Filter by conversation categories
    public let categories: [String]?
    /// Filter by actions that were executed in the conversation
    public let actions: [EntityIdFilter]?
    /// Filter by actions that were suggested but not completed by the AI agent
    public let incompleteActions: [EntityIdFilter]?
    /// Filter by user feedback types received in the conversation
    public let feedback: [FeedbackType]?
    /// Filter by human agents who participated in the conversation
    public let humanAgents: [String]?
    /// Filter by human agents who inserted a maven AI generated suggestion in the conversation
    public let humanAgentsWithInserts: [String]?
    /// Filter by conversation languages
    public let languages: [String]?
    /// Filter by AI assessed conversation quality classification
    public let quality: [Quality]?
    /// Filter by AI assessed quality reason classification
    public let qualityReason: [QualityReason]?
    /// Filter by AI response length classification
    public let responseLength: [ResponseLength]?
    /// Filter by AI assessed sentiment analysis
    public let sentiment: [Sentiment]?
    /// Filter by tags applied to the conversation
    public let tags: [String]?
    /// Filter by agent user IDs associated with the conversation
    public let agentUserIds: [String]?
    /// Filter by conversation resolution status which is determined by AI based on the conversation content.
    public let resolutionStatus: [ResolutionStatus]?
    /// Filter conversations based on whether they were resolved by Maven AI
    public let resolvedByMaven: Bool?
    /// Filter by the number of messages sent by the user in the conversation
    public let userMessageCount: NumberRange?
    /// Filter by whether any message in the conversation has an attachment
    public let hasAttachment: Bool?
    /// Filter by the segments that any message on a conversation matched.
    public let matchedSegmentIds: [EntityIdFilter]?
    /// Filter by inbox item IDs associated with the conversation
    public let inboxItemIds: [EntityIdFilter]?
    /// Whether to include simulation conversations in search results. Defaults to only non-simulation conversations.
    public let simulationFilter: SimulationFilter?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        search: String? = nil,
        createdAfter: Date? = nil,
        createdBefore: Date? = nil,
        apps: [String]? = nil,
        categories: [String]? = nil,
        actions: [EntityIdFilter]? = nil,
        incompleteActions: [EntityIdFilter]? = nil,
        feedback: [FeedbackType]? = nil,
        humanAgents: [String]? = nil,
        humanAgentsWithInserts: [String]? = nil,
        languages: [String]? = nil,
        quality: [Quality]? = nil,
        qualityReason: [QualityReason]? = nil,
        responseLength: [ResponseLength]? = nil,
        sentiment: [Sentiment]? = nil,
        tags: [String]? = nil,
        agentUserIds: [String]? = nil,
        resolutionStatus: [ResolutionStatus]? = nil,
        resolvedByMaven: Bool? = nil,
        userMessageCount: NumberRange? = nil,
        hasAttachment: Bool? = nil,
        matchedSegmentIds: [EntityIdFilter]? = nil,
        inboxItemIds: [EntityIdFilter]? = nil,
        simulationFilter: SimulationFilter? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.search = search
        self.createdAfter = createdAfter
        self.createdBefore = createdBefore
        self.apps = apps
        self.categories = categories
        self.actions = actions
        self.incompleteActions = incompleteActions
        self.feedback = feedback
        self.humanAgents = humanAgents
        self.humanAgentsWithInserts = humanAgentsWithInserts
        self.languages = languages
        self.quality = quality
        self.qualityReason = qualityReason
        self.responseLength = responseLength
        self.sentiment = sentiment
        self.tags = tags
        self.agentUserIds = agentUserIds
        self.resolutionStatus = resolutionStatus
        self.resolvedByMaven = resolvedByMaven
        self.userMessageCount = userMessageCount
        self.hasAttachment = hasAttachment
        self.matchedSegmentIds = matchedSegmentIds
        self.inboxItemIds = inboxItemIds
        self.simulationFilter = simulationFilter
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.search = try container.decodeIfPresent(String.self, forKey: .search)
        self.createdAfter = try container.decodeIfPresent(Date.self, forKey: .createdAfter)
        self.createdBefore = try container.decodeIfPresent(Date.self, forKey: .createdBefore)
        self.apps = try container.decodeIfPresent([String].self, forKey: .apps)
        self.categories = try container.decodeIfPresent([String].self, forKey: .categories)
        self.actions = try container.decodeIfPresent([EntityIdFilter].self, forKey: .actions)
        self.incompleteActions = try container.decodeIfPresent([EntityIdFilter].self, forKey: .incompleteActions)
        self.feedback = try container.decodeIfPresent([FeedbackType].self, forKey: .feedback)
        self.humanAgents = try container.decodeIfPresent([String].self, forKey: .humanAgents)
        self.humanAgentsWithInserts = try container.decodeIfPresent([String].self, forKey: .humanAgentsWithInserts)
        self.languages = try container.decodeIfPresent([String].self, forKey: .languages)
        self.quality = try container.decodeIfPresent([Quality].self, forKey: .quality)
        self.qualityReason = try container.decodeIfPresent([QualityReason].self, forKey: .qualityReason)
        self.responseLength = try container.decodeIfPresent([ResponseLength].self, forKey: .responseLength)
        self.sentiment = try container.decodeIfPresent([Sentiment].self, forKey: .sentiment)
        self.tags = try container.decodeIfPresent([String].self, forKey: .tags)
        self.agentUserIds = try container.decodeIfPresent([String].self, forKey: .agentUserIds)
        self.resolutionStatus = try container.decodeIfPresent([ResolutionStatus].self, forKey: .resolutionStatus)
        self.resolvedByMaven = try container.decodeIfPresent(Bool.self, forKey: .resolvedByMaven)
        self.userMessageCount = try container.decodeIfPresent(NumberRange.self, forKey: .userMessageCount)
        self.hasAttachment = try container.decodeIfPresent(Bool.self, forKey: .hasAttachment)
        self.matchedSegmentIds = try container.decodeIfPresent([EntityIdFilter].self, forKey: .matchedSegmentIds)
        self.inboxItemIds = try container.decodeIfPresent([EntityIdFilter].self, forKey: .inboxItemIds)
        self.simulationFilter = try container.decodeIfPresent(SimulationFilter.self, forKey: .simulationFilter)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.search, forKey: .search)
        try container.encodeIfPresent(self.createdAfter, forKey: .createdAfter)
        try container.encodeIfPresent(self.createdBefore, forKey: .createdBefore)
        try container.encodeIfPresent(self.apps, forKey: .apps)
        try container.encodeIfPresent(self.categories, forKey: .categories)
        try container.encodeIfPresent(self.actions, forKey: .actions)
        try container.encodeIfPresent(self.incompleteActions, forKey: .incompleteActions)
        try container.encodeIfPresent(self.feedback, forKey: .feedback)
        try container.encodeIfPresent(self.humanAgents, forKey: .humanAgents)
        try container.encodeIfPresent(self.humanAgentsWithInserts, forKey: .humanAgentsWithInserts)
        try container.encodeIfPresent(self.languages, forKey: .languages)
        try container.encodeIfPresent(self.quality, forKey: .quality)
        try container.encodeIfPresent(self.qualityReason, forKey: .qualityReason)
        try container.encodeIfPresent(self.responseLength, forKey: .responseLength)
        try container.encodeIfPresent(self.sentiment, forKey: .sentiment)
        try container.encodeIfPresent(self.tags, forKey: .tags)
        try container.encodeIfPresent(self.agentUserIds, forKey: .agentUserIds)
        try container.encodeIfPresent(self.resolutionStatus, forKey: .resolutionStatus)
        try container.encodeIfPresent(self.resolvedByMaven, forKey: .resolvedByMaven)
        try container.encodeIfPresent(self.userMessageCount, forKey: .userMessageCount)
        try container.encodeIfPresent(self.hasAttachment, forKey: .hasAttachment)
        try container.encodeIfPresent(self.matchedSegmentIds, forKey: .matchedSegmentIds)
        try container.encodeIfPresent(self.inboxItemIds, forKey: .inboxItemIds)
        try container.encodeIfPresent(self.simulationFilter, forKey: .simulationFilter)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case search
        case createdAfter
        case createdBefore
        case apps
        case categories
        case actions
        case incompleteActions
        case feedback
        case humanAgents
        case humanAgentsWithInserts
        case languages
        case quality
        case qualityReason
        case responseLength
        case sentiment
        case tags
        case agentUserIds
        case resolutionStatus
        case resolvedByMaven
        case userMessageCount
        case hasAttachment
        case matchedSegmentIds
        case inboxItemIds
        case simulationFilter
    }
}