import Foundation

public struct DeliverUserMessageRequest: Codable, Hashable, Sendable {
    /// The ID of the user to deliver the message to.
    public let userId: EntityIdWithoutAgent
    /// The message to deliver.
    public let message: ConversationMessageRequest
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        userId: EntityIdWithoutAgent,
        message: ConversationMessageRequest,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.userId = userId
        self.message = message
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(EntityIdWithoutAgent.self, forKey: .userId)
        self.message = try container.decode(ConversationMessageRequest.self, forKey: .message)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.message, forKey: .message)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case userId
        case message
    }
}