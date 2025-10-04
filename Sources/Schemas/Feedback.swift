import Foundation

public struct Feedback: Codable, Hashable, Sendable {
    /// The type of feedback
    public let type: FeedbackType
    /// The feedback text
    public let text: String?
    /// The ID of the piece of feedback
    public let feedbackId: EntityId
    /// The ID of the conversation the feedback is about
    public let conversationId: EntityId
    /// The ID of the conversation message the feedback is about
    public let conversationMessageId: EntityId
    /// The ID of the user who created the feedback
    public let userId: EntityId?
    /// The date and time the feedback was created
    public let createdAt: Date?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: FeedbackType,
        text: String? = nil,
        feedbackId: EntityId,
        conversationId: EntityId,
        conversationMessageId: EntityId,
        userId: EntityId? = nil,
        createdAt: Date? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.text = text
        self.feedbackId = feedbackId
        self.conversationId = conversationId
        self.conversationMessageId = conversationMessageId
        self.userId = userId
        self.createdAt = createdAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(FeedbackType.self, forKey: .type)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.feedbackId = try container.decode(EntityId.self, forKey: .feedbackId)
        self.conversationId = try container.decode(EntityId.self, forKey: .conversationId)
        self.conversationMessageId = try container.decode(EntityId.self, forKey: .conversationMessageId)
        self.userId = try container.decodeIfPresent(EntityId.self, forKey: .userId)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
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
        try container.encodeIfPresent(self.createdAt, forKey: .createdAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case text
        case feedbackId
        case conversationId
        case conversationMessageId
        case userId
        case createdAt
    }
}