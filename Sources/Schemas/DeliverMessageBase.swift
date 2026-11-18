import Foundation

public struct DeliverMessageBase: Codable, Hashable, Sendable {
    /// Deprecated. Use `content` with `contentType: message`, which takes the same message.
    /// 
    /// A message to deliver as written. Set exactly one of `message` or `content`.
    public let message: ConversationMessageRequest?
    /// What to deliver. Set exactly one of `message` or `content`.
    public let content: DeliverContent?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        message: ConversationMessageRequest? = nil,
        content: DeliverContent? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.message = message
        self.content = content
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(ConversationMessageRequest.self, forKey: .message)
        self.content = try container.decodeIfPresent(DeliverContent.self, forKey: .content)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.message, forKey: .message)
        try container.encodeIfPresent(self.content, forKey: .content)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case message
        case content
    }
}