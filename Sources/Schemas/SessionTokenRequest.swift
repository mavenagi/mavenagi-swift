import Foundation

public struct SessionTokenRequest: Codable, Hashable, Sendable {
    public let ttlSeconds: Int
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        ttlSeconds: Int,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.ttlSeconds = ttlSeconds
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ttlSeconds = try container.decode(Int.self, forKey: .ttlSeconds)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.ttlSeconds, forKey: .ttlSeconds)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case ttlSeconds
    }
}