import Foundation

/// Initialize conversation with configuration parameters
public struct Config: Codable, Hashable, Sendable {
    public let type: Config
    /// The input audio format from the client.
    public let inputFormat: AudioFormat
    /// The output audio format to send to the client.
    public let outputFormat: AudioFormat
    /// The conversation ID which was created prior to starting this conversation.
    public let conversationId: String
    /// The app ID this conversation ID is associated with.
    public let appId: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: Config,
        inputFormat: AudioFormat,
        outputFormat: AudioFormat,
        conversationId: String,
        appId: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.inputFormat = inputFormat
        self.outputFormat = outputFormat
        self.conversationId = conversationId
        self.appId = appId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(Config.self, forKey: .type)
        self.inputFormat = try container.decode(AudioFormat.self, forKey: .inputFormat)
        self.outputFormat = try container.decode(AudioFormat.self, forKey: .outputFormat)
        self.conversationId = try container.decode(String.self, forKey: .conversationId)
        self.appId = try container.decode(String.self, forKey: .appId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.inputFormat, forKey: .inputFormat)
        try container.encode(self.outputFormat, forKey: .outputFormat)
        try container.encode(self.conversationId, forKey: .conversationId)
        try container.encode(self.appId, forKey: .appId)
    }

    public enum Config: String, Codable, Hashable, CaseIterable, Sendable {
        case config
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case inputFormat
        case outputFormat
        case conversationId
        case appId
    }
}