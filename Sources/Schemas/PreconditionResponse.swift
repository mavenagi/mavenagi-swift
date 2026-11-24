import Foundation

public indirect enum PreconditionResponse: Codable, Hashable, Sendable {
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
        /// The metadata key the precondition reads. Without a `fieldCondition`, a missing key fails the precondition, or meets it when `operator` is `NOT`. With a `fieldCondition`, a missing key is undetermined: it meets only `IS_UNDETERMINED`.
        public let key: String
        /// Single value for CONTAINS operator or exact match. Superseded by `fieldCondition`, which carries its own value; this field and the inherited `operator` apply only without one. Keep using it until `fieldCondition` is generally available.
        public let value: String?
        /// Multiple values for CONTAINS_ANY and CONTAINS_ALL operators. Superseded by `fieldCondition`, which carries its own values; this field and the inherited `operator` apply only without one. Keep using it until `fieldCondition` is generally available.
        public let values: [String]?
        /// A typed condition on the value stored under `key`, used instead of `operator`, `value`
        /// and `values`. On charters, segments and knowledge bases, setting it together with
        /// `operator`, `value` or a non-empty `values` is a 400.
        /// 
        /// Pick the arm by how the value is stored: `string` for a plain string, such as a prefix
        /// or suffix match, and `set` for a JSON array of strings, such as `["us-east","eu-west"]`.
        /// `numeric` and `boolean` read a value written as a number or `true`/`false`.
        /// 
        /// A missing key meets only `universal` `IS_UNDETERMINED`. Every other condition is unmet,
        /// negated ones such as `NOT_STARTS_WITH` and `NEQ` included, unlike `operator: NOT`,
        /// which a missing key meets. To also match a conversation without the key, put the
        /// condition in an `OR` group with `IS_UNDETERMINED`.
        /// 
        /// A `string` condition compares the stored text, unwrapping a JSON-quoted string first, so
        /// a JSON array or number is compared as its raw text. An empty comparison value matches
        /// every value for `STARTS_WITH`, `ENDS_WITH` and `CONTAINS_SUBSTRING`. A `numeric` or
        /// `boolean` condition is unmet when the value cannot be read as that type. A `set`
        /// condition reads a value that is not a JSON array as a one-element set, and skips `null`
        /// elements, so `[null]` is an empty set. A `numeric` `comparison` or `boolean` condition
        /// without a `value` is saved with `0` or `false`, so `{"opType": "comparison",
        /// "operator": "GT"}` means greater than 0.
        public let fieldCondition: FieldCondition?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionOperator? = nil,
            key: String,
            value: String? = nil,
            values: [String]? = nil,
            fieldCondition: FieldCondition? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.key = key
            self.value = value
            self.values = values
            self.fieldCondition = fieldCondition
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
            self.key = try container.decode(String.self, forKey: .key)
            self.value = try container.decodeIfPresent(String.self, forKey: .value)
            self.values = try container.decodeIfPresent([String].self, forKey: .values)
            self.fieldCondition = try container.decodeIfPresent(FieldCondition.self, forKey: .fieldCondition)
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
            try container.encodeIfPresent(self.fieldCondition, forKey: .fieldCondition)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case preconditionType
            case `operator`
            case key
            case value
            case values
            case fieldCondition
        }
    }

    public struct Conversation: Codable, Hashable, Sendable {
        public let preconditionType: String = "conversation"
        public let value: ConversationPreconditionResponse
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            value: ConversationPreconditionResponse,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(ConversationPreconditionResponse.self, forKey: .value)
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
        public let preconditions: [PreconditionResponse]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionGroupOperator,
            preconditions: [PreconditionResponse],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.preconditions = preconditions
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decode(PreconditionGroupOperator.self, forKey: .operator)
            self.preconditions = try container.decode([PreconditionResponse].self, forKey: .preconditions)
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