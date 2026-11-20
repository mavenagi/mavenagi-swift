import Foundation

public struct UsersConversationAudienceResponse: Codable, Hashable, Sendable {
    /// The users the conversation is for, as `initialize` named them: each is a user ID (`type` `USER`) with
    /// the app and reference ID it was given under, the same ID a message's `userId` names. These identify
    /// users of the agent, not `mavenUserId`s.
    public let userIds: [EntityId]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        userIds: [EntityId],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.userIds = userIds
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userIds = try container.decode([EntityId].self, forKey: .userIds)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.userIds, forKey: .userIds)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case userIds
    }
}