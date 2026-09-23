import Foundation

/// A predicate over a string-to-string metadata map: either a condition on the value
/// under one key, or a group of predicates combined with a logical operator.
/// 
/// Kept small on purpose: at most 3 levels of nesting and 10 nodes in total, counting
/// groups as well as entries. A filter is meant to narrow a knowledge base to a
/// recognisable slice, not to encode a query language. Exceeding either is a 400.
public indirect enum MetadataFilter: Codable, Hashable, Sendable {
    case entry(Entry)
    case group(Group)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .metadataFilterType)
        switch discriminant {
        case "entry":
            self = .entry(try Entry(from: decoder))
        case "group":
            self = .group(try Group(from: decoder))
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
        case .group(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Entry: Codable, Hashable, Sendable {
        public let metadataFilterType: String = "entry"
        /// The metadata key to test. A plain key, not a path: metadata is a flat string-to-string map, so there is no nesting to address.
        public let key: String
        /// The condition to evaluate against the value stored under `key`.
        public let condition: MetadataCondition
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            condition: MetadataCondition,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.condition = condition
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.key = try container.decode(String.self, forKey: .key)
            self.condition = try container.decode(MetadataCondition.self, forKey: .condition)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.metadataFilterType, forKey: .metadataFilterType)
            try container.encode(self.key, forKey: .key)
            try container.encode(self.condition, forKey: .condition)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case metadataFilterType
            case key
            case condition
        }
    }

    public struct Group: Codable, Hashable, Sendable {
        public let metadataFilterType: String = "group"
        /// How to combine `filters`.
        public let `operator`: PreconditionGroupOperator
        /// The filters to combine. At least one is required -- a group with no filters constrains
        /// nothing, and omitting the filter altogether already means every document.
        public let filters: [MetadataFilter]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionGroupOperator,
            filters: [MetadataFilter],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.filters = filters
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decode(PreconditionGroupOperator.self, forKey: .operator)
            self.filters = try container.decode([MetadataFilter].self, forKey: .filters)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.metadataFilterType, forKey: .metadataFilterType)
            try container.encode(self.operator, forKey: .operator)
            try container.encode(self.filters, forKey: .filters)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case metadataFilterType
            case `operator`
            case filters
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case metadataFilterType
    }
}