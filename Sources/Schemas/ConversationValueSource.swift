import Foundation

/// Where on a conversation a value is read from.
public enum ConversationValueSource: Codable, Hashable, Sendable {
    case conversationMetadata(ConversationMetadata)
    case userData(UserData)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .type)
        switch discriminant {
        case "conversationMetadata":
            self = .conversationMetadata(try ConversationMetadata(from: decoder))
        case "userData":
            self = .userData(try UserData(from: decoder))
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
        case .conversationMetadata(let data):
            try data.encode(to: encoder)
        case .userData(let data):
            try data.encode(to: encoder)
        }
    }

    public struct ConversationMetadata: Codable, Hashable, Sendable {
        public let type: String = "conversationMetadata"
        /// The conversation metadata key to read.
        public let key: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.key = try container.decode(String.self, forKey: .key)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.key, forKey: .key)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case key
        }
    }

    public struct UserData: Codable, Hashable, Sendable {
        public let type: String = "userData"
        /// The user data key to read.
        public let key: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.key = try container.decode(String.self, forKey: .key)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.key, forKey: .key)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case key
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}