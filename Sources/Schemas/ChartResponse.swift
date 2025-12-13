import Foundation

public enum ChartResponse: Codable, Hashable, Sendable {
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
        /// The dataset for the pie chart.
        /// Each slice in the pie chart is represented as a data point with a name and a corresponding y-value.
        public let series: Series
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            series: Series,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.series = series
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.series = try container.decode(Series.self, forKey: .series)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.series, forKey: .series)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case series
        }
    }

    public struct DateHistogram: Codable, Hashable, Sendable {
        public let type: String = "dateHistogram"
        /// The dataset for the date histogram.
        /// Each series represents a separate plottable time series.
        /// Series names reflect the grouping field values.
        public let timeSeries: [TimeSeries]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            timeSeries: [TimeSeries],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.timeSeries = timeSeries
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.timeSeries = try container.decode([TimeSeries].self, forKey: .timeSeries)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.timeSeries, forKey: .timeSeries)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case timeSeries
        }
    }

    public struct BarChart: Codable, Hashable, Sendable {
        public let type: String = "barChart"
        /// Each LabeledPoint in the series represents a value for the bar, where the name serves as the bar's label.
        /// If vertical grouping is defined, multiple series will be created, each representing a group.
        /// In such cases, the bars can be stacked to reflect the grouped data distribution.
        public let series: [Series]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            series: [Series],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.series = series
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.series = try container.decode([Series].self, forKey: .series)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.series, forKey: .series)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case series
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}