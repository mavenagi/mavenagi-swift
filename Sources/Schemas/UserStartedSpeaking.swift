import Foundation

/// User started speaking
public struct UserStartedSpeaking: Codable, Hashable, Sendable {
    public let eventId: String
    public let type: UserStartedSpeaking
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        eventId: String,
        type: UserStartedSpeaking,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.eventId = eventId
        self.type = type
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventId = try container.decode(String.self, forKey: .eventId)
        self.type = try container.decode(UserStartedSpeaking.self, forKey: .type)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.eventId, forKey: .eventId)
        try container.encode(self.type, forKey: .type)
    }

    public enum UserStartedSpeaking: String, Codable, Hashable, CaseIterable, Sendable {
        case userStartedSpeaking = "user_started_speaking"
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case eventId
        case type
    }
}