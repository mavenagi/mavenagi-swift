import Foundation

public struct ConversationBarChartRequest: Codable, Hashable, Sendable {
    /// Optional filter applied to refine the conversation data before processing.
    public let conversationFilter: ConversationFilter?
    /// IANA timezone identifier (e.g., "America/Los_Angeles").
    /// When provided, time-based groupings (e.g., DAY) and date filters are evaluated in this timezone;
    /// otherwise UTC is used.
    public let timezone: String?
    /// Determines how data is grouped along the x-axis. Each unique value forms a separate bar.
    /// The name of the bar is derived from the grouping field's value or range.
    /// 
    /// **Label Formats by Field:**
    /// - `Sources`: Document title (e.g., "Product Documentation")
    /// - `Actions`: "Action Name - App Name" (e.g., "Create Ticket - Freshdesk")
    /// - `IncompleteActions`: "Action Name - App Name" (e.g., "Search Documents - Zendesk")
    /// - `Users`: User identifier value (e.g., "user@example.com")
    /// - `InboxItems`: Inbox item title
    /// - `HumanAgents`: Human agent display name
    /// - `HumanAgentsWithInserts`: Human agent display name (for agents who made inserts)
    /// - Other fields: Field value as stored (e.g., "GOOD", "NEEDS_IMPROVEMENT" for Quality)
    public let barDefinition: ConversationGroupBy
    /// Metric defining the y-axis values for the bar chart.
    public let metric: ConversationMetric
    /// Optionally defines vertical grouping within each bar, producing multiple series.
    /// If omitted, a single series is generated.
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
    public let verticalGrouping: ConversationGroupBy?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        conversationFilter: ConversationFilter? = nil,
        timezone: String? = nil,
        barDefinition: ConversationGroupBy,
        metric: ConversationMetric,
        verticalGrouping: ConversationGroupBy? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.conversationFilter = conversationFilter
        self.timezone = timezone
        self.barDefinition = barDefinition
        self.metric = metric
        self.verticalGrouping = verticalGrouping
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.conversationFilter = try container.decodeIfPresent(ConversationFilter.self, forKey: .conversationFilter)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        self.barDefinition = try container.decode(ConversationGroupBy.self, forKey: .barDefinition)
        self.metric = try container.decode(ConversationMetric.self, forKey: .metric)
        self.verticalGrouping = try container.decodeIfPresent(ConversationGroupBy.self, forKey: .verticalGrouping)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.conversationFilter, forKey: .conversationFilter)
        try container.encodeIfPresent(self.timezone, forKey: .timezone)
        try container.encode(self.barDefinition, forKey: .barDefinition)
        try container.encode(self.metric, forKey: .metric)
        try container.encodeIfPresent(self.verticalGrouping, forKey: .verticalGrouping)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationFilter
        case timezone
        case barDefinition
        case metric
        case verticalGrouping
    }
}