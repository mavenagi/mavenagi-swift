import Foundation

/// Voice activity detection heard the user start speaking. The client should stop playing and
/// drop any queued agent audio.
public struct VadSpeechStarted: Codable, Hashable, Sendable {
    /// When the server sent the event.
    public let timestamp: Date
    public let type: VadSpeechStarted
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        timestamp: Date,
        type: VadSpeechStarted,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.timestamp = timestamp
        self.type = type
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.type = try container.decode(VadSpeechStarted.self, forKey: .type)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.timestamp, forKey: .timestamp)
        try container.encode(self.type, forKey: .type)
    }

    public enum VadSpeechStarted: String, Codable, Hashable, CaseIterable, Sendable {
        case vadSpeechStarted = "vad_speech_started"
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case timestamp
        case type
    }
}