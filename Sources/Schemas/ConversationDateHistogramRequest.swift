import Foundation

public struct ConversationDateHistogramRequest: Codable, Hashable, Sendable {
    /// Optional filter applied to refine the conversation data before processing.
    public let conversationFilter: ConversationFilter?
    /// IANA timezone identifier (e.g., "America/Los_Angeles").
    /// When provided, time-based groupings (e.g., DAY) and date filters are evaluated in this timezone;
    /// otherwise UTC is used.
    public let timezone: String?
    /// Time-based grouping interval (e.g., HOUR, DAY, WEEK) for the date histogram.
    public let timeInterval: TimeInterval
    /// Groups data before applying calculations, forming a separate time series for each group.
    /// 
    /// **Series Name Formats by Field:**
    /// - `Sources`: Document title (e.g., "Product Documentation")
    /// - `Actions`: "Action Name - App Name" (e.g., "Create Ticket - Freshdesk")
    /// - `IncompleteActions`: "Action Name - App Name" (e.g., "Search Documents - Zendesk")
    /// - `Users`: User identifier value (e.g., "user@example.com")
    /// - `InboxItems`: Inbox item title
    /// - `HumanAgents`: Human agent display name
    /// - `HumanAgentsWithInserts`: Human agent display name (for agents who made inserts)
    /// - Other fields: Field value as stored (e.g., "GOOD", "NEEDS_IMPROVEMENT" for Quality)
    public let groupBy: ConversationGroupBy?
    /// Defines the y-axis values for the date histogram.
    public let metric: ConversationMetric
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        conversationFilter: ConversationFilter? = nil,
        timezone: String? = nil,
        timeInterval: TimeInterval,
        groupBy: ConversationGroupBy? = nil,
        metric: ConversationMetric,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.conversationFilter = conversationFilter
        self.timezone = timezone
        self.timeInterval = timeInterval
        self.groupBy = groupBy
        self.metric = metric
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.conversationFilter = try container.decodeIfPresent(ConversationFilter.self, forKey: .conversationFilter)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        self.timeInterval = try container.decode(TimeInterval.self, forKey: .timeInterval)
        self.groupBy = try container.decodeIfPresent(ConversationGroupBy.self, forKey: .groupBy)
        self.metric = try container.decode(ConversationMetric.self, forKey: .metric)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.conversationFilter, forKey: .conversationFilter)
        try container.encodeIfPresent(self.timezone, forKey: .timezone)
        try container.encode(self.timeInterval, forKey: .timeInterval)
        try container.encodeIfPresent(self.groupBy, forKey: .groupBy)
        try container.encode(self.metric, forKey: .metric)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationFilter
        case timezone
        case timeInterval
        case groupBy
        case metric
    }
}