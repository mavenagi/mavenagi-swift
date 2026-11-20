import Foundation

public struct UsersConversationAudience: Codable, Hashable, Sendable {
    /// The users the conversation is for, identified the same way as a message's `userId`: by
    /// reference ID within the calling app. Must list between 1 and 100 users.
    public let userIds: [EntityIdBase]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        userIds: [EntityIdBase],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.userIds = userIds
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userIds = try container.decode([EntityIdBase].self, forKey: .userIds)
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