import Foundation

public struct Series: Codable, Hashable, Sendable {
    /// The name of the series, derived from the grouping field.
    /// If the metric is a percentile, the name represents the percentile value.
    public let name: String
    /// List of labeled data points for the series.
    public let data: [LabeledPoint]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        data: [LabeledPoint],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.data = data
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.data = try container.decode([LabeledPoint].self, forKey: .data)
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