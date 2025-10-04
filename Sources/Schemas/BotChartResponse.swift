import Foundation

/// Will only be provided if the responseConfig contains the charts_highcharts_ts capability.
public struct BotChartResponse: Codable, Hashable, Sendable {
    /// The label of the chart
    public let label: String
    public let specSchema: ChartSpecSchema
    /// The spec string for the chart. For HIGHCHARTS_TS charts, the spec is the json object that represents the chart options.
    public let spec: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        label: String,
        specSchema: ChartSpecSchema,
        spec: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.label = label
        self.specSchema = specSchema
        self.spec = spec
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.label = try container.decode(String.self, forKey: .label)
        self.specSchema = try container.decode(ChartSpecSchema.self, forKey: .specSchema)
        self.spec = try container.decode(String.self, forKey: .spec)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.label, forKey: .label)
        try container.encode(self.specSchema, forKey: .specSchema)
        try container.encode(self.spec, forKey: .spec)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case label
        case specSchema
        case spec
    }
}