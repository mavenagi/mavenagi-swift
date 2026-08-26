import Foundation

/// A condition on a single value, discriminated by the type the value is
/// validated as. Used wherever a value needs testing regardless of where it
/// came from: an intelligent field's computed value, or a value addressed by
/// path inside data an action returned.
/// 
/// Pick the variant by type:
/// - `string`: For STRING and MULTILINE values
/// - `numeric`: For NUMBER values
/// - `boolean`: For BOOLEAN values
/// - `set`: For MULTI_SELECT values (unordered set of values)
/// 
/// The declared type is what the value is coerced to, not an assertion about
/// how it is already stored. Action data is untyped, so a `numeric` condition
/// against it coerces the same way a `numeric` intelligent field condition
/// coerces a STRING field the bot was asked to answer with a number.
/// 
/// For intelligent fields specifically: single select fields are represented
/// as STRING/NUMBER with a list of enumOptions, and the caller is responsible
/// for querying the validationType and enumOptions from the intelligent field
/// API to ensure the values are valid enumOptions.
public enum FieldCondition: Codable, Hashable, Sendable {
    case boolean(Boolean)
    case numeric(Numeric)
    case set(Set)
    case string(String)
    case universal(Universal)

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
        case "universal":
            self = .universal(try Universal(from: decoder))
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
        case .universal(let data):
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

    public struct Universal: Codable, Hashable, Sendable {
        public let fieldValidationType: Swift.String = "universal"
        public let value: UniversalCondition
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [Swift.String: JSONValue]

        public init(
            value: UniversalCondition,
            additionalProperties: [Swift.String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(UniversalCondition.self, forKey: .value)
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