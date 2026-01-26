import Foundation

/// AI ended the conversation
public struct ConversationEnded: Codable, Hashable, Sendable {
    public let eventId: String
    public let type: ConversationEnded
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        eventId: String,
        type: ConversationEnded,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.eventId = eventId
        self.type = type
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventId = try container.decode(String.self, forKey: .eventId)
        self.type = try container.decode(ConversationEnded.self, forKey: .type)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.eventId, forKey: .eventId)
        try container.encode(self.type, forKey: .type)
    }

    public enum ConversationEnded: String, Codable, Hashable, CaseIterable, Sendable {
        case conversationEnded = "conversation_ended"
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case eventId
        case type
    }
}