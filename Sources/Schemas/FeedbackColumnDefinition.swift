import Foundation

public struct FeedbackColumnDefinition: Codable, Hashable, Sendable {
    /// Unique column header, serving as the key for corresponding metric values.
    public let header: String
    /// The metric calculated for this column, stored in the row data under the specified header.
    public let metric: FeedbackMetric
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        header: String,
        metric: FeedbackMetric,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.header = header
        self.metric = metric
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.header = try container.decode(String.self, forKey: .header)
        self.metric = try container.decode(FeedbackMetric.self, forKey: .metric)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.header, forKey: .header)
        try container.encode(self.metric, forKey: .metric)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case header
        case metric
    }
}