import Foundation

public enum DeliverMessageRequest: Codable, Hashable, Sendable {
    case conversation(Conversation)
    case user(User)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .type)
        switch discriminant {
        case "conversation":
            self = .conversation(try Conversation(from: decoder))
        case "user":
            self = .user(try User(from: decoder))
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
        case .conversation(let data):
            try data.encode(to: encoder)
        case .user(let data):
            try data.encode(to: encoder)
        }
    }

    public struct User: Codable, Hashable, Sendable {
        public let type: String = "user"
        /// Deprecated. Use `content` with `contentType: message`, which takes the same message.
        /// 
        /// A message to deliver as written. Set exactly one of `message` or `content`.
        public let message: ConversationMessageRequest?
        /// What to deliver. Set exactly one of `message` or `content`.
        public let content: DeliverContent?
        /// The ID of the user to deliver the message to.
        public let userId: EntityIdWithoutAgent
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            message: ConversationMessageRequest? = nil,
            content: DeliverContent? = nil,
            userId: EntityIdWithoutAgent,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.message = message
            self.content = content
            self.userId = userId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.message = try container.decodeIfPresent(ConversationMessageRequest.self, forKey: .message)
            self.content = try container.decodeIfPresent(DeliverContent.self, forKey: .content)
            self.userId = try container.decode(EntityIdWithoutAgent.self, forKey: .userId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encodeIfPresent(self.message, forKey: .message)
            try container.encodeIfPresent(self.content, forKey: .content)
            try container.encode(self.userId, forKey: .userId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case message
            case content
            case userId
        }
    }

    public struct Conversation: Codable, Hashable, Sendable {
        public let type: String = "conversation"
        /// Deprecated. Use `content` with `contentType: message`, which takes the same message.
        /// 
        /// A message to deliver as written. Set exactly one of `message` or `content`.
        public let message: ConversationMessageRequest?
        /// What to deliver. Set exactly one of `message` or `content`.
        public let content: DeliverContent?
        /// The ID of the conversation to deliver the message to. Message delivery will fail if the conversation does not have the `ASYNC` capability, and a closed conversation (`open` set to false) returns a 400.
        public let conversationId: EntityIdWithoutAgent
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            message: ConversationMessageRequest? = nil,
            content: DeliverContent? = nil,
            conversationId: EntityIdWithoutAgent,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.message = message
            self.content = content
            self.conversationId = conversationId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.message = try container.decodeIfPresent(ConversationMessageRequest.self, forKey: .message)
            self.content = try container.decodeIfPresent(DeliverContent.self, forKey: .content)
            self.conversationId = try container.decode(EntityIdWithoutAgent.self, forKey: .conversationId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encodeIfPresent(self.message, forKey: .message)
            try container.encodeIfPresent(self.content, forKey: .content)
            try container.encode(self.conversationId, forKey: .conversationId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case message
            case content
            case conversationId
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}