import Foundation

public enum EventChartRequest: Codable, Hashable, Sendable {
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
        /// Optional filter applied to refine the event data before processing.
        public let eventFilter: EventFilter?
        /// IANA timezone identifier (e.g., "America/Los_Angeles").
        /// When provided, time-based groupings (e.g., DAY) and date filters are evaluated in this timezone;
        /// otherwise UTC is used.
        public let timezone: String?
        /// Field used to group data into slices for the pie chart.
        public let groupBy: EventGroupBy
        /// Metric defining the value for each pie slice, stored in the y-axis value.
        public let metric: EventMetric
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            eventFilter: EventFilter? = nil,
            timezone: String? = nil,
            groupBy: EventGroupBy,
            metric: EventMetric,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.eventFilter = eventFilter
            self.timezone = timezone
            self.groupBy = groupBy
            self.metric = metric
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.eventFilter = try container.decodeIfPresent(EventFilter.self, forKey: .eventFilter)
            self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
            self.groupBy = try container.decode(EventGroupBy.self, forKey: .groupBy)
            self.metric = try container.decode(EventMetric.self, forKey: .metric)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encodeIfPresent(self.eventFilter, forKey: .eventFilter)
            try container.encodeIfPresent(self.timezone, forKey: .timezone)
            try container.encode(self.groupBy, forKey: .groupBy)
            try container.encode(self.metric, forKey: .metric)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case eventFilter
            case timezone
            case groupBy
            case metric
        }
    }

    public struct DateHistogram: Codable, Hashable, Sendable {
        public let type: String = "dateHistogram"
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
            try container.encode(self.type, forKey: .type)
            try container.encodeIfPresent(self.eventFilter, forKey: .eventFilter)
            try container.encodeIfPresent(self.timezone, forKey: .timezone)
            try container.encode(self.timeInterval, forKey: .timeInterval)
            try container.encodeIfPresent(self.groupBy, forKey: .groupBy)
            try container.encode(self.metric, forKey: .metric)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case eventFilter
            case timezone
            case timeInterval
            case groupBy
            case metric
        }
    }

    public struct BarChart: Codable, Hashable, Sendable {
        public let type: String = "barChart"
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
            try container.encode(self.type, forKey: .type)
            try container.encodeIfPresent(self.eventFilter, forKey: .eventFilter)
            try container.encodeIfPresent(self.timezone, forKey: .timezone)
            try container.encode(self.barDefinition, forKey: .barDefinition)
            try container.encode(self.metric, forKey: .metric)
            try container.encodeIfPresent(self.verticalGrouping, forKey: .verticalGrouping)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case eventFilter
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