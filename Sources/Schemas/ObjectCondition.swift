import Foundation

/// A condition on a JSON object.
public enum ObjectCondition: Codable, Hashable, Sendable {
    case entry(Entry)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .objectConditionType)
        switch discriminant {
        case "entry":
            self = .entry(try Entry(from: decoder))
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
        case .entry(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Entry: Codable, Hashable, Sendable {
        public let objectConditionType: String = "entry"
        /// Dot-separated path to a value inside the object, e.g. `name` or `customer.tier`. Array elements are indexed with brackets (`orders[0].id`), and a key containing a dot needs bracket notation (`['a.b']`). A path that reaches nothing resolves to undetermined rather than failing.
        /// The path must address a single value. Wildcards, filters, slices and recursive descent (`orders[*].total`, `$..total`) address many values and are rejected, as is a path with a syntax error.
        public let path: String
        /// The condition to evaluate against the value at `path`.
        public let condition: IntelligentFieldCondition
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            path: String,
            condition: IntelligentFieldCondition,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.path = path
            self.condition = condition
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.path = try container.decode(String.self, forKey: .path)
            self.condition = try container.decode(IntelligentFieldCondition.self, forKey: .condition)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.objectConditionType, forKey: .objectConditionType)
            try container.encode(self.path, forKey: .path)
            try container.encode(self.condition, forKey: .condition)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case objectConditionType
            case path
            case condition
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case objectConditionType
    }
}