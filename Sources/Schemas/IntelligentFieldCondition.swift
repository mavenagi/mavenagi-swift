import Foundation

/// The condition to evaluate against an intelligent field's value.
/// Use the appropriate type based on the field's validationType:
/// - `string`: For STRING and MULTILINE fields
/// - `numeric`: For NUMBER fields
/// - `boolean`: For BOOLEAN fields
/// - `set`: For MULTI_SELECT fields (unordered set of values)
/// 
/// Note: single select fields are represented as STRING/NUMBER with a list of
/// enumOptions.
/// 
/// The caller is responsible for querying the validationType and enumOptions
/// from the intelligent field API to ensure the values are valid enumOptions.
public enum IntelligentFieldCondition: Codable, Hashable, Sendable {
    case boolean(Boolean)
    case numeric(Numeric)
    case set(Set)
    case string(String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(Swift.String.self, forKey: .fieldValidationType)
        switch discriminant {
        case "boolean":
            self = .boolean(try Boolean(from: decoder))
        case "numeric":
            self = .numeric(try Numeric(from: decoder))
        case "set":
            self = .set(try Set(from: decoder))
        case "string":
            self = .string(try String(from: decoder))
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
        case .boolean(let data):
            try data.encode(to: encoder)
        case .numeric(let data):
            try data.encode(to: encoder)
        case .set(let data):
            try data.encode(to: encoder)
        case .string(let data):
            try data.encode(to: encoder)
        }
    }

    public struct String: Codable, Hashable, Sendable {
        public let fieldValidationType: Swift.String = "string"
        public let value: StringCondition
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [Swift.String: JSONValue]

        public init(
            value: StringCondition,
            additionalProperties: [Swift.String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(StringCondition.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.fieldValidationType, forKey: .fieldValidationType)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case fieldValidationType
            case value
        }
    }

    public struct Numeric: Codable, Hashable, Sendable {
        public let fieldValidationType: Swift.String = "numeric"
        public let value: NumericCondition
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [Swift.String: JSONValue]

        public init(
            value: NumericCondition,
            additionalProperties: [Swift.String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(NumericCondition.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.fieldValidationType, forKey: .fieldValidationType)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case fieldValidationType
            case value
        }
    }

    public struct Boolean: Codable, Hashable, Sendable {
        public let fieldValidationType: Swift.String = "boolean"
        /// The expected boolean value (true or false)
        public let value: Bool
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [Swift.String: JSONValue]

        public init(
            value: Bool,
            additionalProperties: [Swift.String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(Bool.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.fieldValidationType, forKey: .fieldValidationType)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case fieldValidationType
            case value
        }
    }

    public struct Set: Codable, Hashable, Sendable {
        public let fieldValidationType: Swift.String = "set"
        public let value: SetCondition
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [Swift.String: JSONValue]

        public init(
            value: SetCondition,
            additionalProperties: [Swift.String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(SetCondition.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.fieldValidationType, forKey: .fieldValidationType)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case fieldValidationType
            case value
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case fieldValidationType
    }
}