import Foundation

public indirect enum Precondition: Codable, Hashable, Sendable {
    case conversation(Conversation)
    case group(Group)
    case user(User)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .preconditionType)
        switch discriminant {
        case "conversation":
            self = .conversation(try Conversation(from: decoder))
        case "group":
            self = .group(try Group(from: decoder))
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
        case .group(let data):
            try data.encode(to: encoder)
        case .user(let data):
            try data.encode(to: encoder)
        }
    }

    public struct User: Codable, Hashable, Sendable {
        public let preconditionType: String = "user"
        /// Operator to apply to this precondition
        public let `operator`: PreconditionOperator?
        /// The key that must be present in the metadata for a precondition to be met
        public let key: String
        /// Single value for CONTAINS operator or exact match
        public let value: String?
        /// Multiple values for CONTAINS_ANY and CONTAINS_ALL operators
        public let values: [String]?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionOperator? = nil,
            key: String,
            value: String? = nil,
            values: [String]? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.key = key
            self.value = value
            self.values = values
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
            self.key = try container.decode(String.self, forKey: .key)
            self.value = try container.decodeIfPresent(String.self, forKey: .value)
            self.values = try container.decodeIfPresent([String].self, forKey: .values)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.preconditionType, forKey: .preconditionType)
            try container.encodeIfPresent(self.operator, forKey: .operator)
            try container.encode(self.key, forKey: .key)
            try container.encodeIfPresent(self.value, forKey: .value)
            try container.encodeIfPresent(self.values, forKey: .values)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case preconditionType
            case `operator`
            case key
            case value
            case values
        }
    }

    public struct Conversation: Codable, Hashable, Sendable {
        public let preconditionType: String = "conversation"
        public let value: ConversationPrecondition
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            value: ConversationPrecondition,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(ConversationPrecondition.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.preconditionType, forKey: .preconditionType)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case preconditionType
            case value
        }
    }

    public struct Group: Codable, Hashable, Sendable {
        public let preconditionType: String = "group"
        public let `operator`: PreconditionGroupOperator
        public let preconditions: [Precondition]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionGroupOperator,
            preconditions: [Precondition],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.preconditions = preconditions
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decode(PreconditionGroupOperator.self, forKey: .operator)
            self.preconditions = try container.decode([Precondition].self, forKey: .preconditions)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.preconditionType, forKey: .preconditionType)
            try container.encode(self.operator, forKey: .operator)
            try container.encode(self.preconditions, forKey: .preconditions)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case preconditionType
            case `operator`
            case preconditions
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case preconditionType
    }
}