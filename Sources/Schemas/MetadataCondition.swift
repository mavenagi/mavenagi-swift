import Foundation

/// A condition on a single metadata value.
/// 
/// Unlike `FieldCondition` this has no type discriminant. `FieldCondition` coerces a
/// value to a declared type before comparing it because the values it tests may be
/// numbers, booleans or sets; metadata values are always strings, so there is nothing
/// to declare.
public enum MetadataCondition: Codable, Hashable, Sendable {
    case comparison(Comparison)
    case membership(Membership)
    case presence(Presence)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .opType)
        switch discriminant {
        case "comparison":
            self = .comparison(try Comparison(from: decoder))
        case "membership":
            self = .membership(try Membership(from: decoder))
        case "presence":
            self = .presence(try Presence(from: decoder))
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
        case .comparison(let data):
            try data.encode(to: encoder)
        case .membership(let data):
            try data.encode(to: encoder)
        case .presence(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Comparison: Codable, Hashable, Sendable {
        public let opType: String = "comparison"
        /// The comparison operator to apply
        public let `operator`: MetadataComparisonOperator
        /// The string value to compare against
        public let value: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: MetadataComparisonOperator,
            value: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decode(MetadataComparisonOperator.self, forKey: .operator)
            self.value = try container.decode(String.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.opType, forKey: .opType)
            try container.encode(self.operator, forKey: .operator)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case opType
            case `operator`
            case value
        }
    }

    public struct Membership: Codable, Hashable, Sendable {
        public let opType: String = "membership"
        /// The comparison operator to apply
        public let `operator`: StringMembershipOperator
        /// The set of string values to compare against
        public let values: [String]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: StringMembershipOperator,
            values: [String],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.values = values
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decode(StringMembershipOperator.self, forKey: .operator)
            self.values = try container.decode([String].self, forKey: .values)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.opType, forKey: .opType)
            try container.encode(self.operator, forKey: .operator)
            try container.encode(self.values, forKey: .values)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case opType
            case `operator`
            case values
        }
    }

    public struct Presence: Codable, Hashable, Sendable {
        public let opType: String = "presence"
        /// The presence operator to apply
        public let `operator`: PresenceOperator
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PresenceOperator,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decode(PresenceOperator.self, forKey: .operator)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.opType, forKey: .opType)
            try container.encode(self.operator, forKey: .operator)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case opType
            case `operator`
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case opType
    }
}