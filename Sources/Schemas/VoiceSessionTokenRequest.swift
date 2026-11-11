import Foundation

public struct VoiceSessionTokenRequest: Codable, Hashable, Sendable {
    /// The end user identity for the voice session.
    /// Must contain only alphanumeric characters, dots, hyphens, or underscores.
    /// For "webrtc" tokens, at most 184 characters. A longer value fails with 400.
    public let appUserId: String
    /// The type of session token to generate.
    /// Use "webrtc" for browser-based calls, or "websocket" for direct WebSocket connections.
    /// For "webrtc", `transport` selects the Maven telephony gateway (default) or Twilio.
    public let type: VoiceTokenType
    /// The transport for a "webrtc" call. Default: "gateway".
    /// - "gateway": the response `token` is a token for the Maven telephony gateway, and the response includes `connectUrl`.
    /// - "twilio": the response `token` is a Twilio access token.
    /// 
    /// The server ignores this field for "websocket" tokens.
    public let transport: VoiceWebRtcTransport?
    /// Arbitrary key-value metadata to associate with this session (e.g., conversationId, topic).
    /// 
    /// **Constraints**: at most 10 keys, each key up to 256 characters, each value up to 500 characters.
    /// A request that exceeds any limit fails with 400 and lists each field that exceeded it; values are never truncated.
    /// For WebRTC calls, each key is stored in conversation metadata as `custom_<key>`.
    /// Values are stored as-is — for small data, embed the value directly (e.g., `"callerName": "John Doe"`).
    /// 
    /// For WebRTC tokens, this data is stored server-side and referenced by a secure ID
    /// encoded in the token identity, ensuring it cannot be tampered with by the client.
    public let customData: [String: String]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        appUserId: String,
        type: VoiceTokenType,
        transport: VoiceWebRtcTransport? = nil,
        customData: [String: String]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.appUserId = appUserId
        self.type = type
        self.transport = transport
        self.customData = customData
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appUserId = try container.decode(String.self, forKey: .appUserId)
        self.type = try container.decode(VoiceTokenType.self, forKey: .type)
        self.transport = try container.decodeIfPresent(VoiceWebRtcTransport.self, forKey: .transport)
        self.customData = try container.decodeIfPresent([String: String].self, forKey: .customData)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.appUserId, forKey: .appUserId)
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.transport, forKey: .transport)
        try container.encodeIfPresent(self.customData, forKey: .customData)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case appUserId
        case type
        case transport
        case customData
    }
}