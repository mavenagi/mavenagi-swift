import Foundation

/// Defines the metric to be calculated for a column or chart.
/// Only numeric fields are supported, except for ConversationCount and ConversationDistinctCount, which can be applied to any field.
public enum ConversationMetric: Codable, Hashable, Sendable {
    case average(Average)
    case count(Count)
    case distinctCount(DistinctCount)
    case max(Max)
    case median(Median)
    case min(Min)
    case percentile(Percentile)
    case sum(Sum)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .type)
        switch discriminant {
        case "average":
            self = .average(try Average(from: decoder))
        case "count":
            self = .count(try Count(from: decoder))
        case "distinctCount":
            self = .distinctCount(try DistinctCount(from: decoder))
        case "max":
            self = .max(try Max(from: decoder))
        case "median":
            self = .median(try Median(from: decoder))
        case "min":
            self = .min(try Min(from: decoder))
        case "percentile":
            self = .percentile(try Percentile(from: decoder))
        case "sum":
            self = .sum(try Sum(from: decoder))
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
        case .average(let data):
            try data.encode(to: encoder)
        case .count(let data):
            try data.encode(to: encoder)
        case .distinctCount(let data):
            try data.encode(to: encoder)
        case .max(let data):
            try data.encode(to: encoder)
        case .median(let data):
            try data.encode(to: encoder)
        case .min(let data):
            try data.encode(to: encoder)
        case .percentile(let data):
            try data.encode(to: encoder)
        case .sum(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Count: Codable, Hashable, Sendable {
        public let type: String = "count"
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            self.additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
        }
    }

    public struct Sum: Codable, Hashable, Sendable {
        public let type: String = "sum"
        /// Numeric field to apply the metric to.
        public let targetField: NumericConversationField
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            targetField: NumericConversationField,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.targetField = targetField
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.targetField = try container.decode(NumericConversationField.self, forKey: .targetField)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.targetField, forKey: .targetField)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case targetField
        }
    }

    public struct Average: Codable, Hashable, Sendable {
        public let type: String = "average"
        /// Numeric field to apply the metric to.
        public let targetField: NumericConversationField
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            targetField: NumericConversationField,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.targetField = targetField
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.targetField = try container.decode(NumericConversationField.self, forKey: .targetField)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.targetField, forKey: .targetField)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case targetField
        }
    }

    public struct Min: Codable, Hashable, Sendable {
        public let type: String = "min"
        /// Numeric field to apply the metric to.
        public let targetField: NumericConversationField
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            targetField: NumericConversationField,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.targetField = targetField
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.targetField = try container.decode(NumericConversationField.self, forKey: .targetField)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.targetField, forKey: .targetField)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case targetField
        }
    }

    public struct Max: Codable, Hashable, Sendable {
        public let type: String = "max"
        /// Numeric field to apply the metric to.
        public let targetField: NumericConversationField
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            targetField: NumericConversationField,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.targetField = targetField
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.targetField = try container.decode(NumericConversationField.self, forKey: .targetField)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.targetField, forKey: .targetField)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case targetField
        }
    }

    public struct Percentile: Codable, Hashable, Sendable {
        public let type: String = "percentile"
        /// Numeric field to apply the metric to.
        public let targetField: NumericConversationField
        /// The percentile to calculate. Example: 25 computes the 25th percentile.
        public let percentile: Double
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            targetField: NumericConversationField,
            percentile: Double,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.targetField = targetField
            self.percentile = percentile
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.targetField = try container.decode(NumericConversationField.self, forKey: .targetField)
            self.percentile = try container.decode(Double.self, forKey: .percentile)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.targetField, forKey: .targetField)
            try container.encode(self.percentile, forKey: .percentile)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case targetField
            case percentile
        }
    }

    public struct Median: Codable, Hashable, Sendable {
        public let type: String = "median"
        /// Numeric field to apply the metric to.
        public let targetField: NumericConversationField
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            targetField: NumericConversationField,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.targetField = targetField
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.targetField = try container.decode(NumericConversationField.self, forKey: .targetField)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.targetField, forKey: .targetField)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case targetField
        }
    }

    public struct DistinctCount: Codable, Hashable, Sendable {
        public let type: String = "distinctCount"
        /// Field to apply the metric to.
        public let targetField: ConversationField
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            targetField: ConversationField,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.targetField = targetField
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.targetField = try container.decode(ConversationField.self, forKey: .targetField)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.targetField, forKey: .targetField)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case targetField
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}