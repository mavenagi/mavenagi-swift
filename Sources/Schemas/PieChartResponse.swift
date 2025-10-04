import Foundation

public struct PieChartResponse: Codable, Hashable, Sendable {
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
        try container.encode(self.series, forKey: .series)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case series
    }
}