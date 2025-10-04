import Foundation

public struct DateHistogramResponse: Codable, Hashable, Sendable {
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
        try container.encode(self.timeSeries, forKey: .timeSeries)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case timeSeries
    }
}