import Foundation

public enum ObjectStreamResponse: Codable, Hashable, Sendable {
    case text(Text)
    case start(Start)
    case end(End)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .eventType)
        switch discriminant {
        case "text":
            self = .text(try Text(from: decoder))
        case "start":
            self = .start(try Start(from: decoder))
        case "end":
            self = .end(try End(from: decoder))
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
        case .text(let data):
            try data.encode(to: encoder)
        case .start(let data):
            try data.encode(to: encoder)
        case .end(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Text: Codable, Hashable, Sendable {
        public let eventType: String = "text"
        /// A partial response to the question. All stream text events should be concatenated to form the full response.
        public let contents: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            contents: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.contents = contents
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.contents = try container.decode(String.self, forKey: .contents)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventType, forKey: .eventType)
            try container.encode(self.contents, forKey: .contents)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventType
            case contents
        }
    }

    public struct Start: Codable, Hashable, Sendable {
        public let eventType: String = "start"
        public let conversationMessageId: EntityId
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            conversationMessageId: EntityId,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.conversationMessageId = conversationMessageId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.conversationMessageId = try container.decode(EntityId.self, forKey: .conversationMessageId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventType, forKey: .eventType)
            try container.encode(self.conversationMessageId, forKey: .conversationMessageId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventType
            case conversationMessageId
        }
    }

    public struct End: Codable, Hashable, Sendable {
        public let eventType: String = "end"
        public let error: ErrorMessage?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            error: ErrorMessage? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.error = error
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(ErrorMessage.self, forKey: .error)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventType, forKey: .eventType)
            try container.encodeIfPresent(self.error, forKey: .error)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventType
            case error
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case eventType
    }
}