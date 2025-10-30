import Foundation

public struct ConversationPieChartRequest: Codable, Hashable, Sendable {
    /// Optional filter applied to refine the conversation data before processing.
    public let conversationFilter: ConversationFilter?
    /// IANA timezone identifier (e.g., "America/Los_Angeles").
    /// When provided, time-based groupings (e.g., DAY) and date filters are evaluated in this timezone;
    /// otherwise UTC is used.
    public let timezone: String?
    /// Field used to group data into slices for the pie chart.
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
    public let groupBy: ConversationGroupBy
    /// Metric defining the value for each pie slice, stored in the y-axis value.
    public let metric: ConversationMetric
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        conversationFilter: ConversationFilter? = nil,
        timezone: String? = nil,
        groupBy: ConversationGroupBy,
        metric: ConversationMetric,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.conversationFilter = conversationFilter
        self.timezone = timezone
        self.groupBy = groupBy
        self.metric = metric
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.conversationFilter = try container.decodeIfPresent(ConversationFilter.self, forKey: .conversationFilter)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        self.groupBy = try container.decode(ConversationGroupBy.self, forKey: .groupBy)
        self.metric = try container.decode(ConversationMetric.self, forKey: .metric)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.conversationFilter, forKey: .conversationFilter)
        try container.encodeIfPresent(self.timezone, forKey: .timezone)
        try container.encode(self.groupBy, forKey: .groupBy)
        try container.encode(self.metric, forKey: .metric)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationFilter
        case timezone
        case groupBy
        case metric
    }
}