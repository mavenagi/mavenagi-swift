import Foundation

public struct SessionTokenResponse: Codable, Hashable, Sendable {
    /// The session token to use for authentication.
    public let sessionToken: String
    /// When the session token expires.
    public let expiresAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        sessionToken: String,
        expiresAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.sessionToken = sessionToken
        self.expiresAt = expiresAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sessionToken = try container.decode(String.self, forKey: .sessionToken)
        self.expiresAt = try container.decode(Date.self, forKey: .expiresAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.sessionToken, forKey: .sessionToken)
        try container.encode(self.expiresAt, forKey: .expiresAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case sessionToken
        case expiresAt
    }
}