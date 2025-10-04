import Foundation

public struct ExecuteCapabilityResponse: Codable, Hashable, Sendable {
    public let ok: Bool
    public let body: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        ok: Bool,
        body: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.ok = ok
        self.body = body
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ok = try container.decode(Bool.self, forKey: .ok)
        self.body = try container.decode(String.self, forKey: .body)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.ok, forKey: .ok)
        try container.encode(self.body, forKey: .body)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case ok
        case body
    }
}