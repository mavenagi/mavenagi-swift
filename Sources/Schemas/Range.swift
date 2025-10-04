import Foundation

public struct Range: Codable, Hashable, Sendable {
    /// Lower bound of the range (inclusive).
    public let from: Double?
    /// Upper bound of the range (exclusive).
    public let to: Double?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        from: Double? = nil,
        to: Double? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.from = from
        self.to = to
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.from = try container.decodeIfPresent(Double.self, forKey: .from)
        self.to = try container.decodeIfPresent(Double.self, forKey: .to)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.from, forKey: .from)
        try container.encodeIfPresent(self.to, forKey: .to)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case from
        case to
    }
}