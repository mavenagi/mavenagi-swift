import Foundation

/// A condition on the value stored under one metadata key.
public struct MetadataEntryCondition: Codable, Hashable, Sendable {
    /// The metadata key to test. A plain key, not a path: metadata is a flat string-to-string map, so there is no nesting to address.
    public let key: String
    /// The condition to evaluate against the value stored under `key`.
    public let condition: MetadataCondition
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        key: String,
        condition: MetadataCondition,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.key = key
        self.condition = condition
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decode(String.self, forKey: .key)
        self.condition = try container.decode(MetadataCondition.self, forKey: .condition)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.key, forKey: .key)
        try container.encode(self.condition, forKey: .condition)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case key
        case condition
    }
}