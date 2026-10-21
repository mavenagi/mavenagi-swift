import Foundation

/// What a capability is simulated with, by kind. Only actions can be simulated today; a variant
/// is added for each kind as it becomes simulation-aware.
public enum CapabilitySimulationInput: Codable, Hashable, Sendable {
    case action(Action)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .capabilityType)
        switch discriminant {
        case "ACTION":
            self = .action(try Action(from: decoder))
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
        case .action(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Action: Codable, Hashable, Sendable {
        public let capabilityType: String = "ACTION"
        /// The conversation's metadata, as the capability would read it.
        public let conversationMetadata: [String: String]?
        /// The user the capability runs for. Omit it to run for an anonymous user.
        public let user: SimulatedUser?
        /// Data passed to the capability for this run only and never stored.
        public let transientData: [String: String]?
        /// The action's parameters, keyed by parameter ID.
        public let parameters: [String: JSONValue]?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            conversationMetadata: [String: String]? = nil,
            user: SimulatedUser? = nil,
            transientData: [String: String]? = nil,
            parameters: [String: JSONValue]? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.conversationMetadata = conversationMetadata
            self.user = user
            self.transientData = transientData
            self.parameters = parameters
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.conversationMetadata = try container.decodeIfPresent([String: String].self, forKey: .conversationMetadata)
            self.user = try container.decodeIfPresent(SimulatedUser.self, forKey: .user)
            self.transientData = try container.decodeIfPresent([String: String].self, forKey: .transientData)
            self.parameters = try container.decodeIfPresent([String: JSONValue].self, forKey: .parameters)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.capabilityType, forKey: .capabilityType)
            try container.encodeIfPresent(self.conversationMetadata, forKey: .conversationMetadata)
            try container.encodeIfPresent(self.user, forKey: .user)
            try container.encodeIfPresent(self.transientData, forKey: .transientData)
            try container.encodeIfPresent(self.parameters, forKey: .parameters)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case capabilityType
            case conversationMetadata
            case user
            case transientData
            case parameters
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case capabilityType
    }
}