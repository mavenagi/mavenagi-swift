import Foundation

public struct DeliverConversationMessageRequest: Codable, Hashable, Sendable {
    /// The ID of the conversation to deliver the message to. Message delivery will fail if the conversation does not have the `ASYNC` capability or if it is not `open`.
    public let conversationId: EntityIdWithoutAgent
    /// The message to deliver.
    public let message: ConversationMessageRequest
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        conversationId: EntityIdWithoutAgent,
        message: ConversationMessageRequest,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.conversationId = conversationId
        self.message = message
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.conversationId = try container.decode(EntityIdWithoutAgent.self, forKey: .conversationId)
        self.message = try container.decode(ConversationMessageRequest.self, forKey: .message)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.conversationId, forKey: .conversationId)
        try container.encode(self.message, forKey: .message)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationId
        case message
    }
}