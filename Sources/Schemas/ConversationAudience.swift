import Foundation

public enum ConversationAudience: Codable, Hashable, Sendable {
    /// Any of the agent's users may take part in the conversation. Equivalent to omitting `audience`.
    case allUsers(AllUsers)
    /// Only the listed users may take part in the conversation. A `USER` message from anyone else is
    /// rejected with a 400 on `ask`, `askStream` and `appendNewMessages`, and on the `initialize` that
    /// creates the conversation; a repeat `initialize` saves no messages. Messages from human agents and
    /// external systems are not checked, and voice caller messages are not checked yet.
    case users(Users)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .type)
        switch discriminant {
        case "allUsers":
            self = .allUsers(try AllUsers(from: decoder))
        case "users":
            self = .users(try Users(from: decoder))
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown shape discriminant value: \(discriminant)"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws -> Void {
        switch self {
        case .allUsers(let data):
            try data.encode(to: encoder)
        case .users(let data):
            try data.encode(to: encoder)
        }
    }

    /// Any of the agent's users may take part in the conversation. Equivalent to omitting `audience`.
    public struct AllUsers: Codable, Hashable, Sendable {
        public let type: String = "allUsers"
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            self.additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
        }
    }

    /// Only the listed users may take part in the conversation. A `USER` message from anyone else is
    /// rejected with a 400 on `ask`, `askStream` and `appendNewMessages`, and on the `initialize` that
    /// creates the conversation; a repeat `initialize` saves no messages. Messages from human agents and
    /// external systems are not checked, and voice caller messages are not checked yet.
    public struct Users: Codable, Hashable, Sendable {
        public let type: String = "users"
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
            try container.encode(self.type, forKey: .type)
            try container.encode(self.userIds, forKey: .userIds)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case userIds
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}