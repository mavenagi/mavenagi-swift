import Foundation

/// Defines the metric to be calculated for a column or chart.
public enum FeedbackMetric: Codable, Hashable, Sendable {
    case count(Count)
    case distinctCount(DistinctCount)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .type)
        switch discriminant {
        case "count":
            self = .count(try Count(from: decoder))
        case "distinctCount":
            self = .distinctCount(try DistinctCount(from: decoder))
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
        case .count(let data):
            try data.encode(to: encoder)
        case .distinctCount(let data):
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

    public struct DistinctCount: Codable, Hashable, Sendable {
        public let type: String = "distinctCount"
        /// All the distinct values of this field will be counted.
        public let targetField: FeedbackField
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            targetField: FeedbackField,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.targetField = targetField
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.targetField = try container.decode(FeedbackField.self, forKey: .targetField)
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