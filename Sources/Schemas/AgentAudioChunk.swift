import Foundation

/// Audio chunk to send into the conversation.
public struct AgentAudioChunk: Codable, Hashable, Sendable {
    public let eventId: String
    public let type: AgentAudioChunk
    /// Base64-encoded AI audio data
    public let data: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        eventId: String,
        type: AgentAudioChunk,
        data: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.eventId = eventId
        self.type = type
        self.data = data
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventId = try container.decode(String.self, forKey: .eventId)
        self.type = try container.decode(AgentAudioChunk.self, forKey: .type)
        self.data = try container.decode(String.self, forKey: .data)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.eventId, forKey: .eventId)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.data, forKey: .data)
    }

    public enum AgentAudioChunk: String, Codable, Hashable, CaseIterable, Sendable {
        case agentAudioChunk = "agent_audio_chunk"
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case eventId
        case type
        case data
    }
}