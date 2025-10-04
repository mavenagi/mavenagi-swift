import Foundation

public struct FeedbackRequest: Codable, Hashable, Sendable {
    /// The type of feedback
    public let type: FeedbackType
    /// The feedback text
    public let text: String?
    /// The ID that uniquely identifies this feedback
    public let feedbackId: EntityIdBase
    /// The ID that uniquely identifies the the conversation the feedback is about
    public let conversationId: EntityIdBase
    /// The ID that uniquely identifies the message within the conversation the feedback is about
    public let conversationMessageId: EntityIdBase
    /// The ID of the user who is creating the feedback
    public let userId: EntityIdBase?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: FeedbackType,
        text: String? = nil,
        feedbackId: EntityIdBase,
        conversationId: EntityIdBase,
        conversationMessageId: EntityIdBase,
        userId: EntityIdBase? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.text = text
        self.feedbackId = feedbackId
        self.conversationId = conversationId
        self.conversationMessageId = conversationMessageId
        self.userId = userId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(FeedbackType.self, forKey: .type)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.feedbackId = try container.decode(EntityIdBase.self, forKey: .feedbackId)
        self.conversationId = try container.decode(EntityIdBase.self, forKey: .conversationId)
        self.conversationMessageId = try container.decode(EntityIdBase.self, forKey: .conversationMessageId)
        self.userId = try container.decodeIfPresent(EntityIdBase.self, forKey: .userId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.text, forKey: .text)
        try container.encode(self.feedbackId, forKey: .feedbackId)
        try container.encode(self.conversationId, forKey: .conversationId)
        try container.encode(self.conversationMessageId, forKey: .conversationMessageId)
        try container.encodeIfPresent(self.userId, forKey: .userId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case text
        case feedbackId
        case conversationId
        case conversationMessageId
        case userId
    }
}