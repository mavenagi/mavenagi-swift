import Foundation

/// Echo of a server `mark` message. Send it, with the same `name`, once all agent audio received
/// before that mark has played. Agent audio the client drops (for example on `vad_speech_started`)
/// counts as played. A missing echo delays the agent until a server-side timeout.
public struct ClientMark: Codable, Hashable, Sendable {
    public let type: Mark
    /// The `name` from the server `mark` message.
    public let name: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: Mark,
        name: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.name = name
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(Mark.self, forKey: .type)
        self.name = try container.decode(String.self, forKey: .name)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.name, forKey: .name)
    }

    public enum Mark: String, Codable, Hashable, CaseIterable, Sendable {
        case mark
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case name
    }
}