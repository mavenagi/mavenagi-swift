import Foundation

public struct LabeledPoint: Codable, Hashable, Sendable {
    /// Label for the data point corresponding to the y-value.
    public let label: String
    /// Value of the data point.
    public let y: Double
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        label: String,
        y: Double,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.label = label
        self.y = y
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.label = try container.decode(String.self, forKey: .label)
        self.y = try container.decode(Double.self, forKey: .y)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.label, forKey: .label)
        try container.encode(self.y, forKey: .y)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case label
        case y
    }
}