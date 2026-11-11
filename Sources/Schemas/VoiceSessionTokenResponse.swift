import Foundation

public struct VoiceSessionTokenResponse: Codable, Hashable, Sendable {
    /// Opaque session token. Pass this in the Authorization header when connecting.
    /// For "websocket", the token is an ES256 JWT.
    /// For "webrtc", the token format depends on `transport`.
    public let token: String
    /// The identity string associated with this token (echoes appUserId).
    public let identity: String
    /// The type of token that was generated.
    public let type: VoiceTokenType
    /// Time in seconds until the token expires.
    public let expiresIn: Int
    /// The URL that starts a "webrtc" call through the Maven telephony gateway.
    /// The client sends `token` to this URL to start the call.
    /// Present only when the request sets `transport` to "gateway".
    public let connectUrl: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        token: String,
        identity: String,
        type: VoiceTokenType,
        expiresIn: Int,
        connectUrl: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.token = token
        self.identity = identity
        self.type = type
        self.expiresIn = expiresIn
        self.connectUrl = connectUrl
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decode(String.self, forKey: .token)
        self.identity = try container.decode(String.self, forKey: .identity)
        self.type = try container.decode(VoiceTokenType.self, forKey: .type)
        self.expiresIn = try container.decode(Int.self, forKey: .expiresIn)
        self.connectUrl = try container.decodeIfPresent(String.self, forKey: .connectUrl)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.token, forKey: .token)
        try container.encode(self.identity, forKey: .identity)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.expiresIn, forKey: .expiresIn)
        try container.encodeIfPresent(self.connectUrl, forKey: .connectUrl)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case token
        case identity
        case type
        case expiresIn
        case connectUrl
    }
}