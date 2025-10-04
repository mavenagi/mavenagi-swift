import Foundation

public struct AskStreamStartEvent: Codable, Hashable, Sendable {
    public let conversationMessageId: EntityId
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        conversationMessageId: EntityId,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.conversationMessageId = conversationMessageId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.conversationMessageId = try container.decode(EntityId.self, forKey: .conversationMessageId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.conversationMessageId, forKey: .conversationMessageId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationMessageId
    }
}