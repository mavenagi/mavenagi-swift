import Foundation

public enum ConversationChartRequest: Codable, Hashable, Sendable {
    case barChart(BarChart)
    case dateHistogram(DateHistogram)
    case pieChart(PieChart)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .type)
        switch discriminant {
        case "barChart":
            self = .barChart(try BarChart(from: decoder))
        case "dateHistogram":
            self = .dateHistogram(try DateHistogram(from: decoder))
        case "pieChart":
            self = .pieChart(try PieChart(from: decoder))
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown shape discriminant value: \(discriminant)"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws -> Void {
        switch self {
        case .barChart(let data):
            try data.encode(to: encoder)
        case .dateHistogram(let data):
            try data.encode(to: encoder)
        case .pieChart(let data):
            try data.encode(to: encoder)
        }
    }

    public struct PieChart: Codable, Hashable, Sendable {
        public let type: String = "pieChart"
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
            try container.encode(self.type, forKey: .type)
            try container.encodeIfPresent(self.conversationFilter, forKey: .conversationFilter)
            try container.encodeIfPresent(self.timezone, forKey: .timezone)
            try container.encode(self.groupBy, forKey: .groupBy)
            try container.encode(self.metric, forKey: .metric)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case conversationFilter
            case timezone
            case groupBy
            case metric
        }
    }

    public struct DateHistogram: Codable, Hashable, Sendable {
        public let type: String = "dateHistogram"
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
            try container.encode(self.type, forKey: .type)
            try container.encodeIfPresent(self.conversationFilter, forKey: .conversationFilter)
            try container.encodeIfPresent(self.timezone, forKey: .timezone)
            try container.encode(self.timeInterval, forKey: .timeInterval)
            try container.encodeIfPresent(self.groupBy, forKey: .groupBy)
            try container.encode(self.metric, forKey: .metric)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case conversationFilter
            case timezone
            case timeInterval
            case groupBy
            case metric
        }
    }

    public struct BarChart: Codable, Hashable, Sendable {
        public let type: String = "barChart"
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
            try container.encode(self.type, forKey: .type)
            try container.encodeIfPresent(self.conversationFilter, forKey: .conversationFilter)
            try container.encodeIfPresent(self.timezone, forKey: .timezone)
            try container.encode(self.barDefinition, forKey: .barDefinition)
            try container.encode(self.metric, forKey: .metric)
            try container.encodeIfPresent(self.verticalGrouping, forKey: .verticalGrouping)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case conversationFilter
            case timezone
            case barDefinition
            case metric
            case verticalGrouping
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}