import Foundation

public struct UserMessageBase: Codable, Hashable, Sendable {
    /// The date and time the conversation was created
    public let createdAt: Date?
    /// The date and time the conversation was last updated
    public let updatedAt: Date?
    /// ID that uniquely identifies the user that created this message
    public let userId: EntityIdBase
    /// The text of the message. Cannot be empty
    public let text: String
    public let userMessageType: UserConversationMessageType
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        userId: EntityIdBase,
        text: String,
        userMessageType: UserConversationMessageType,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.userId = userId
        self.text = text
        self.userMessageType = userMessageType
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.userId = try container.decode(EntityIdBase.self, forKey: .userId)
        self.text = try container.decode(String.self, forKey: .text)
        self.userMessageType = try container.decode(UserConversationMessageType.self, forKey: .userMessageType)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.createdAt, forKey: .createdAt)
        try container.encodeIfPresent(self.updatedAt, forKey: .updatedAt)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.text, forKey: .text)
        try container.encode(self.userMessageType, forKey: .userMessageType)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case createdAt
        case updatedAt
        case userId
        case text
        case userMessageType
    }
}