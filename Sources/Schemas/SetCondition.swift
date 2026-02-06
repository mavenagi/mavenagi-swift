import Foundation

/// Condition for set values (e.g., MULTI_SELECT fields)
public enum SetCondition: Codable, Hashable, Sendable {
    case element(Element)
    case relation(Relation)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .opType)
        switch discriminant {
        case "element":
            self = .element(try Element(from: decoder))
        case "relation":
            self = .relation(try Relation(from: decoder))
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
        case .element(let data):
            try data.encode(to: encoder)
        case .relation(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Element: Codable, Hashable, Sendable {
        public let opType: String = "element"
        /// The comparison operator to apply
        public let `operator`: SetElementOperator
        /// The value to check for
        public let value: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: SetElementOperator,
            value: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decode(SetElementOperator.self, forKey: .operator)
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

    public struct Relation: Codable, Hashable, Sendable {
        public let opType: String = "relation"
        /// The comparison operator to apply
        public let `operator`: SetRelationOperator
        /// The (unordered) set of values to compare against
        public let values: JSONValue
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: SetRelationOperator,
            values: JSONValue,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.values = values
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decode(SetRelationOperator.self, forKey: .operator)
            self.values = try container.decode(JSONValue.self, forKey: .values)
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

    enum CodingKeys: String, CodingKey, CaseIterable {
        case opType
    }
}