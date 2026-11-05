import Foundation

/// Error occurred during conversation
public struct Error: Codable, Hashable, Sendable {
    /// When the server sent the event.
    public let timestamp: Date
    public let type: Error
    public let message: String
    /// One of:
    /// - `invalid_message`: the server could not parse a client message, or its `type` is unknown.
    /// - `invalid_configuration`: `outputFormat` differs from `inputFormat`.
    /// - `invalid_audio_format`: the format is not `PCM_8000` or `MULAW_8000`.
    /// - `initialization_error`: the connection failed before the conversation started, including authentication and rate-limit failures.
    /// - `internal_error`: the voice model reported an error during the conversation.
    public let code: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        timestamp: Date,
        type: Error,
        message: String,
        code: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.timestamp = timestamp
        self.type = type
        self.message = message
        self.code = code
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.type = try container.decode(Error.self, forKey: .type)
        self.message = try container.decode(String.self, forKey: .message)
        self.code = try container.decode(String.self, forKey: .code)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.timestamp, forKey: .timestamp)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.message, forKey: .message)
        try container.encode(self.code, forKey: .code)
    }

    public enum Error: String, Codable, Hashable, CaseIterable, Sendable {
        case error
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case timestamp
        case type
        case message
        case code
    }
}