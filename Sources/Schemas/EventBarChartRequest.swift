import Foundation

public struct EventBarChartRequest: Codable, Hashable, Sendable {
    /// Optional filter applied to refine the event data before processing.
    public let eventFilter: EventFilter?
    /// IANA timezone identifier (e.g., "America/Los_Angeles").
    /// When provided, time-based groupings (e.g., DAY) and date filters are evaluated in this timezone;
    /// otherwise UTC is used.
    public let timezone: String?
    /// Determines how data is grouped along the x-axis. Each unique value forms a separate bar.
    public let barDefinition: EventGroupBy
    /// Metric defining the y-axis values for the bar chart.
    public let metric: EventMetric
    /// Optionally defines vertical grouping within each bar, producing multiple series.
    /// If omitted, a single series is generated.
    public let verticalGrouping: EventGroupBy?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        eventFilter: EventFilter? = nil,
        timezone: String? = nil,
        barDefinition: EventGroupBy,
        metric: EventMetric,
        verticalGrouping: EventGroupBy? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.eventFilter = eventFilter
        self.timezone = timezone
        self.barDefinition = barDefinition
        self.metric = metric
        self.verticalGrouping = verticalGrouping
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventFilter = try container.decodeIfPresent(EventFilter.self, forKey: .eventFilter)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        self.barDefinition = try container.decode(EventGroupBy.self, forKey: .barDefinition)
        self.metric = try container.decode(EventMetric.self, forKey: .metric)
        self.verticalGrouping = try container.decodeIfPresent(EventGroupBy.self, forKey: .verticalGrouping)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.eventFilter, forKey: .eventFilter)
        try container.encodeIfPresent(self.timezone, forKey: .timezone)
        try container.encode(self.barDefinition, forKey: .barDefinition)
        try container.encode(self.metric, forKey: .metric)
        try container.encodeIfPresent(self.verticalGrouping, forKey: .verticalGrouping)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case eventFilter
        case timezone
        case barDefinition
        case metric
        case verticalGrouping
    }
}