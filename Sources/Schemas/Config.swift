import Foundation

/// Initialize conversation with configuration parameters
public struct Config: Codable, Hashable, Sendable {
    public let type: Config
    /// The audio format the client sends. Must be `PCM_8000` or `MULAW_8000`.
    public let inputFormat: AudioFormat
    /// The audio format the server sends. Must equal `inputFormat`, or the server returns an `invalid_configuration` error.
    public let outputFormat: AudioFormat
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: Config,
        inputFormat: AudioFormat,
        outputFormat: AudioFormat,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.inputFormat = inputFormat
        self.outputFormat = outputFormat
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(Config.self, forKey: .type)
        self.inputFormat = try container.decode(AudioFormat.self, forKey: .inputFormat)
        self.outputFormat = try container.decode(AudioFormat.self, forKey: .outputFormat)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.inputFormat, forKey: .inputFormat)
        try container.encode(self.outputFormat, forKey: .outputFormat)
    }

    public enum Config: String, Codable, Hashable, CaseIterable, Sendable {
        case config
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case inputFormat
        case outputFormat
    }
}