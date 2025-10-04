import Foundation

public struct ActionOAuthConfiguration: Codable, Hashable, Sendable {
    public let authorizationUrl: String
    public let tokenUrl: String
    public let clientId: String
    public let clientSecret: String
    public let scopes: [String]
    public let extraAuthParams: [String: String]?
    public let extraTokenParams: [String: String]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        authorizationUrl: String,
        tokenUrl: String,
        clientId: String,
        clientSecret: String,
        scopes: [String],
        extraAuthParams: [String: String]? = nil,
        extraTokenParams: [String: String]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.authorizationUrl = authorizationUrl
        self.tokenUrl = tokenUrl
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.scopes = scopes
        self.extraAuthParams = extraAuthParams
        self.extraTokenParams = extraTokenParams
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.authorizationUrl = try container.decode(String.self, forKey: .authorizationUrl)
        self.tokenUrl = try container.decode(String.self, forKey: .tokenUrl)
        self.clientId = try container.decode(String.self, forKey: .clientId)
        self.clientSecret = try container.decode(String.self, forKey: .clientSecret)
        self.scopes = try container.decode([String].self, forKey: .scopes)
        self.extraAuthParams = try container.decodeIfPresent([String: String].self, forKey: .extraAuthParams)
        self.extraTokenParams = try container.decodeIfPresent([String: String].self, forKey: .extraTokenParams)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.authorizationUrl, forKey: .authorizationUrl)
        try container.encode(self.tokenUrl, forKey: .tokenUrl)
        try container.encode(self.clientId, forKey: .clientId)
        try container.encode(self.clientSecret, forKey: .clientSecret)
        try container.encode(self.scopes, forKey: .scopes)
        try container.encodeIfPresent(self.extraAuthParams, forKey: .extraAuthParams)
        try container.encodeIfPresent(self.extraTokenParams, forKey: .extraTokenParams)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case authorizationUrl
        case tokenUrl
        case clientId
        case clientSecret
        case scopes
        case extraAuthParams
        case extraTokenParams
    }
}