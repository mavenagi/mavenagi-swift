import Foundation

/// Transcribed agent speech
public struct AgentTranscript: Codable, Hashable, Sendable {
    public let eventId: String
    public let type: AgentTranscript
    /// Transcribed agent speech
    public let text: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        eventId: String,
        type: AgentTranscript,
        text: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.eventId = eventId
        self.type = type
        self.text = text
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventId = try container.decode(String.self, forKey: .eventId)
        self.type = try container.decode(AgentTranscript.self, forKey: .type)
        self.text = try container.decode(String.self, forKey: .text)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.eventId, forKey: .eventId)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.text, forKey: .text)
    }

    public enum AgentTranscript: String, Codable, Hashable, CaseIterable, Sendable {
        case agentTranscript = "agent_transcript"
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case eventId
        case type
        case text
    }
}