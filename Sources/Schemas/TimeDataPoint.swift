import Foundation

public struct TimeDataPoint: Codable, Hashable, Sendable {
    /// X-axis value representing time in epoch milliseconds.
    public let x: Int64
    /// Y-axis value representing the measured data.
    public let y: Double
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        x: Int64,
        y: Double,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.x = x
        self.y = y
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.x = try container.decode(Int64.self, forKey: .x)
        self.y = try container.decode(Double.self, forKey: .y)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.x, forKey: .x)
        try container.encode(self.y, forKey: .y)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case x
        case y
    }
}