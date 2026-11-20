import Foundation

public enum ConversationAudienceResponse: Codable, Hashable, Sendable {
    /// Any of the agent's users may take part in the conversation.
    case allUsers(AllUsers)
    /// Only the listed users may take part in the conversation.
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

    /// Any of the agent's users may take part in the conversation.
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

    /// Only the listed users may take part in the conversation.
    public struct Users: Codable, Hashable, Sendable {
        public let type: String = "users"
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