import Foundation

/// Type-independent conditions that apply to any intelligent field regardless of its
/// validationType. Currently only a presence (determined/undetermined) check. Modeled as
/// its own discriminated union so future type-independent operators can be added without
/// changing the top-level IntelligentFieldCondition union.
public enum UniversalCondition: Codable, Hashable, Sendable {
    case presence(Presence)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .opType)
        switch discriminant {
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
        case .presence(let data):
            try data.encode(to: encoder)
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