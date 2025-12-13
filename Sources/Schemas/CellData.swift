import Foundation

public enum CellData: Codable, Hashable, Sendable {
    case double(Double)
    case long(Long)
    case millisecond(Millisecond)
    case string(String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(Swift.String.self, forKey: .type)
        switch discriminant {
        case "double":
            self = .double(try Double(from: decoder))
        case "long":
            self = .long(try Long(from: decoder))
        case "millisecond":
            self = .millisecond(try Millisecond(from: decoder))
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
        case .double(let data):
            try data.encode(to: encoder)
        case .long(let data):
            try data.encode(to: encoder)
        case .millisecond(let data):
            try data.encode(to: encoder)
        case .string(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Double: Codable, Hashable, Sendable {
        public let type: Swift.String = "double"
        public let value: Swift.Double
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [Swift.String: JSONValue]

        public init(
            value: Swift.Double,
            additionalProperties: [Swift.String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(Swift.Double.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case value
        }
    }

    public struct Long: Codable, Hashable, Sendable {
        public let type: Swift.String = "long"
        public let value: Int64
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [Swift.String: JSONValue]

        public init(
            value: Int64,
            additionalProperties: [Swift.String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(Int64.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case value
        }
    }

    public struct Millisecond: Codable, Hashable, Sendable {
        public let type: Swift.String = "millisecond"
        public let value: Swift.Double
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [Swift.String: JSONValue]

        public init(
            value: Swift.Double,
            additionalProperties: [Swift.String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(Swift.Double.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case value
        }
    }

    public struct String: Codable, Hashable, Sendable {
        public let type: Swift.String = "string"
        public let value: Swift.String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [Swift.String: JSONValue]

        public init(
            value: Swift.String,
            additionalProperties: [Swift.String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(Swift.String.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case value
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}