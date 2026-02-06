import Foundation

/// Condition for numeric values
public enum NumericCondition: Codable, Hashable, Sendable {
    case comparison(Comparison)
    case membership(Membership)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .opType)
        switch discriminant {
        case "comparison":
            self = .comparison(try Comparison(from: decoder))
        case "membership":
            self = .membership(try Membership(from: decoder))
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
        }
    }

    public struct Comparison: Codable, Hashable, Sendable {
        public let opType: String = "comparison"
        /// The comparison operator to apply
        public let `operator`: NumericComparisonOperator
        /// The numeric value to compare against
        public let value: Double
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: NumericComparisonOperator,
            value: Double,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decode(NumericComparisonOperator.self, forKey: .operator)
            self.value = try container.decode(Double.self, forKey: .value)
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
        public let `operator`: NumericMembershipOperator
        /// The set of numeric values to compare against
        public let values: [Double]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: NumericMembershipOperator,
            values: [Double],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.values = values
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decode(NumericMembershipOperator.self, forKey: .operator)
            self.values = try container.decode([Double].self, forKey: .values)
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