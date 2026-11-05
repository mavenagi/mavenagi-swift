import Foundation

/// Voice activity detection heard the user stop speaking.
public struct VadSpeechStopped: Codable, Hashable, Sendable {
    /// When the server sent the event.
    public let timestamp: Date
    public let type: VadSpeechStopped
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        timestamp: Date,
        type: VadSpeechStopped,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.timestamp = timestamp
        self.type = type
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.type = try container.decode(VadSpeechStopped.self, forKey: .type)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.timestamp, forKey: .timestamp)
        try container.encode(self.type, forKey: .type)
    }

    public enum VadSpeechStopped: String, Codable, Hashable, CaseIterable, Sendable {
        case vadSpeechStopped = "vad_speech_stopped"
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case timestamp
        case type
    }
}