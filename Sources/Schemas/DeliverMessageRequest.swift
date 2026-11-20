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
        /// The apps whose conversations may receive the message, in order of preference. Omit it to allow any app; an empty list is rejected with a 400.
        /// 
        /// The message goes to a conversation that already exists, is open, has the `ASYNC` capability, is owned
        /// by an allowed app, and lists this user in a `users` audience (set by `initialize`'s `audience`). A
        /// conversation with an `allUsers` audience, or with none, is never chosen. Apps are tried in the order
        /// given, and within an app the most recently updated conversation wins; with `appIds` omitted, the most
        /// recently updated conversation of any app wins. An `ask` also skips conversations with `llmEnabled`
        /// set to false.
        /// 
        /// The message goes to one conversation only. To reach the user in several apps, send one request per app.
        /// Whether an app is installed is not checked when choosing: the message is handed to the chosen
        /// conversation's app, and if that app fails to take it, `status` is `FAILED` and no other app is tried.
        /// 
        /// When no conversation qualifies, nothing is delivered and `status` is `FAILED`.
        /// 
        /// Only 20 of a user's open `ASYNC` conversations are considered. If a user has more, an arbitrary 20
        /// are, so the most recent one may be missed. Close conversations that no longer take messages.
        public let appIds: [String]?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            message: ConversationMessageRequest? = nil,
            content: DeliverContent? = nil,
            userId: EntityIdWithoutAgent,
            appIds: [String]? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.message = message
            self.content = content
            self.userId = userId
            self.appIds = appIds
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.message = try container.decodeIfPresent(ConversationMessageRequest.self, forKey: .message)
            self.content = try container.decodeIfPresent(DeliverContent.self, forKey: .content)
            self.userId = try container.decode(EntityIdWithoutAgent.self, forKey: .userId)
            self.appIds = try container.decodeIfPresent([String].self, forKey: .appIds)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encodeIfPresent(self.message, forKey: .message)
            try container.encodeIfPresent(self.content, forKey: .content)
            try container.encode(self.userId, forKey: .userId)
            try container.encodeIfPresent(self.appIds, forKey: .appIds)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case message
            case content
            case userId
            case appIds
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