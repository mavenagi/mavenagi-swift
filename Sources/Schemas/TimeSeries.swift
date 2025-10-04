import Foundation

public struct TimeSeries: Codable, Hashable, Sendable {
    /// Name of the series, derived from the grouping field or percentile metric.
    public let name: String
    /// List of time-based data points for the series.
    public let data: [TimeDataPoint]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        data: [TimeDataPoint],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.data = data
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.data = try container.decode([TimeDataPoint].self, forKey: .data)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.data, forKey: .data)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case data
    }
}