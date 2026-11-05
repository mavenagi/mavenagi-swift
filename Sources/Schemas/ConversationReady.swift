import Foundation

/// Conversation created successfully. The client may start sending audio.
public struct ConversationReady: Codable, Hashable, Sendable {
    /// When the server sent the event.
    public let timestamp: Date
    public let type: ConversationReady
    /// The conversation ID the server created for this connection.
    public let sessionId: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        timestamp: Date,
        type: ConversationReady,
        sessionId: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.timestamp = timestamp
        self.type = type
        self.sessionId = sessionId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.type = try container.decode(ConversationReady.self, forKey: .type)
        self.sessionId = try container.decode(String.self, forKey: .sessionId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.timestamp, forKey: .timestamp)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.sessionId, forKey: .sessionId)
    }

    public enum ConversationReady: String, Codable, Hashable, CaseIterable, Sendable {
        case conversationReady = "conversation_ready"
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case timestamp
        case type
        case sessionId
    }
}