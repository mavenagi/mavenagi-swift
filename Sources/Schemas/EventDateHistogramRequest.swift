import Foundation

public struct EventDateHistogramRequest: Codable, Hashable, Sendable {
    /// Optional filter applied to refine the event data before processing.
    public let eventFilter: EventFilter?
    /// IANA timezone identifier (e.g., "America/Los_Angeles").
    /// When provided, time-based groupings (e.g., DAY) and date filters are evaluated in this timezone;
    /// otherwise UTC is used.
    public let timezone: String?
    /// Time-based grouping interval (e.g., HOUR, DAY, WEEK) for the date histogram.
    public let timeInterval: TimeInterval
    /// Groups data before applying calculations, forming a separate time series for each group.
    public let groupBy: EventGroupBy?
    /// Defines the y-axis values for the date histogram.
    public let metric: EventMetric
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        eventFilter: EventFilter? = nil,
        timezone: String? = nil,
        timeInterval: TimeInterval,
        groupBy: EventGroupBy? = nil,
        metric: EventMetric,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.eventFilter = eventFilter
        self.timezone = timezone
        self.timeInterval = timeInterval
        self.groupBy = groupBy
        self.metric = metric
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventFilter = try container.decodeIfPresent(EventFilter.self, forKey: .eventFilter)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        self.timeInterval = try container.decode(TimeInterval.self, forKey: .timeInterval)
        self.groupBy = try container.decodeIfPresent(EventGroupBy.self, forKey: .groupBy)
        self.metric = try container.decode(EventMetric.self, forKey: .metric)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.eventFilter, forKey: .eventFilter)
        try container.encodeIfPresent(self.timezone, forKey: .timezone)
        try container.encode(self.timeInterval, forKey: .timeInterval)
        try container.encodeIfPresent(self.groupBy, forKey: .groupBy)
        try container.encode(self.metric, forKey: .metric)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case eventFilter
        case timezone
        case timeInterval
        case groupBy
        case metric
    }
}