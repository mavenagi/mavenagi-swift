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
            try container.encode(self.type, forKey: .type)
            try container.encode(self.userId, forKey: .userId)
            try container.encode(self.message, forKey: .message)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case userId
            case message
        }
    }

    public struct Conversation: Codable, Hashable, Sendable {
        public let type: String = "conversation"
        /// The ID of the conversation to deliver the message to. Message delivery will fail if the conversation does not have the `ASYNC` capability or if it is not `open`.
        public let conversationId: EntityIdWithoutAgent
        /// The message to deliver.
        public let message: ConversationMessageRequest
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            conversationId: EntityIdWithoutAgent,
            message: ConversationMessageRequest,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.conversationId = conversationId
            self.message = message
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.conversationId = try container.decode(EntityIdWithoutAgent.self, forKey: .conversationId)
            self.message = try container.decode(ConversationMessageRequest.self, forKey: .message)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.conversationId, forKey: .conversationId)
            try container.encode(self.message, forKey: .message)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case conversationId
            case message
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}