import Foundation

/// Transcript of a completed user or agent utterance.
public struct Transcript: Codable, Hashable, Sendable {
    /// When the server sent the event.
    public let timestamp: Date
    public let type: Transcript
    /// Who spoke.
    public let role: TranscriptRole
    /// Transcribed speech.
    public let text: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        timestamp: Date,
        type: Transcript,
        role: TranscriptRole,
        text: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.timestamp = timestamp
        self.type = type
        self.role = role
        self.text = text
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.type = try container.decode(Transcript.self, forKey: .type)
        self.role = try container.decode(TranscriptRole.self, forKey: .role)
        self.text = try container.decode(String.self, forKey: .text)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.timestamp, forKey: .timestamp)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.role, forKey: .role)
        try container.encode(self.text, forKey: .text)
    }

    public enum Transcript: String, Codable, Hashable, CaseIterable, Sendable {
        case transcript
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case timestamp
        case type
        case role
        case text
    }
}