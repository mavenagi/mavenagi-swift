import Foundation

/// An object ID that states the level its object lives at: `AGENT` (it belongs to an agent),
/// `ORGANIZATION` (it belongs to an organization and to none of its agents), or `CROSS_ORGANIZATION` (it
/// is above the organization level). An `AGENT` ID has the same fields as `EntityId`, plus `level`. An ID
/// sent without `level` is read as `AGENT`.
public enum LeveledEntityId: Codable, Hashable, Sendable {
    /// An object that belongs to an agent.
    case agent(Agent)
    /// An object above the organization level.
    case crossOrganization(CrossOrganization)
    /// An object that belongs to an organization and to none of its agents.
    case organization(Organization)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .level)
        switch discriminant {
        case "AGENT":
            self = .agent(try Agent(from: decoder))
        case "CROSS_ORGANIZATION":
            self = .crossOrganization(try CrossOrganization(from: decoder))
        case "ORGANIZATION":
            self = .organization(try Organization(from: decoder))
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
        case .agent(let data):
            try data.encode(to: encoder)
        case .crossOrganization(let data):
            try data.encode(to: encoder)
        case .organization(let data):
            try data.encode(to: encoder)
        }
    }

    /// An object that belongs to an agent.
    public struct Agent: Codable, Hashable, Sendable {
        public let level: String = "AGENT"
        /// The object type
        public let type: EntityType
        /// The ID of the application that created this object
        public let appId: String
        /// Externally supplied ID to uniquely identify this object. Is globally unique when combined with the other fields of its ID.
        /// 
        /// Must be less than 192 characters and contain only:
        /// - alphanumeric characters (`a-z`, `A-Z`, `0-9`)
        /// - hyphens (`-`)
        /// - underscores (`_`)
        /// - plus signs (`+`)
        /// - periods (`.`)
        /// - at symbol (`@`)
        /// - pipe symbol (`|`)
        public let referenceId: String
        /// The ID of the organization that this object belongs to
        public let organizationId: String
        /// The ID of the agent that this object belongs to
        public let agentId: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            type: EntityType,
            appId: String,
            referenceId: String,
            organizationId: String,
            agentId: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.type = type
            self.appId = appId
            self.referenceId = referenceId
            self.organizationId = organizationId
            self.agentId = agentId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.type = try container.decode(EntityType.self, forKey: .type)
            self.appId = try container.decode(String.self, forKey: .appId)
            self.referenceId = try container.decode(String.self, forKey: .referenceId)
            self.organizationId = try container.decode(String.self, forKey: .organizationId)
            self.agentId = try container.decode(String.self, forKey: .agentId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.level, forKey: .level)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.appId, forKey: .appId)
            try container.encode(self.referenceId, forKey: .referenceId)
            try container.encode(self.organizationId, forKey: .organizationId)
            try container.encode(self.agentId, forKey: .agentId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case level
            case type
            case appId
            case referenceId
            case organizationId
            case agentId
        }
    }

    /// An object that belongs to an organization and to none of its agents.
    public struct Organization: Codable, Hashable, Sendable {
        public let level: String = "ORGANIZATION"
        /// The object type
        public let type: EntityType
        /// The ID of the application that created this object
        public let appId: String
        /// Externally supplied ID to uniquely identify this object. Is globally unique when combined with the other fields of its ID.
        /// 
        /// Must be less than 192 characters and contain only:
        /// - alphanumeric characters (`a-z`, `A-Z`, `0-9`)
        /// - hyphens (`-`)
        /// - underscores (`_`)
        /// - plus signs (`+`)
        /// - periods (`.`)
        /// - at symbol (`@`)
        /// - pipe symbol (`|`)
        public let referenceId: String
        /// The ID of the organization that this object belongs to
        public let organizationId: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            type: EntityType,
            appId: String,
            referenceId: String,
            organizationId: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.type = type
            self.appId = appId
            self.referenceId = referenceId
            self.organizationId = organizationId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.type = try container.decode(EntityType.self, forKey: .type)
            self.appId = try container.decode(String.self, forKey: .appId)
            self.referenceId = try container.decode(String.self, forKey: .referenceId)
            self.organizationId = try container.decode(String.self, forKey: .organizationId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.level, forKey: .level)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.appId, forKey: .appId)
            try container.encode(self.referenceId, forKey: .referenceId)
            try container.encode(self.organizationId, forKey: .organizationId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case level
            case type
            case appId
            case referenceId
            case organizationId
        }
    }

    /// An object above the organization level.
    public struct CrossOrganization: Codable, Hashable, Sendable {
        public let level: String = "CROSS_ORGANIZATION"
        /// The object type
        public let type: EntityType
        /// The ID of the application that created this object
        public let appId: String
        /// Externally supplied ID to uniquely identify this object. Is globally unique when combined with the other fields of its ID.
        /// 
        /// Must be less than 192 characters and contain only:
        /// - alphanumeric characters (`a-z`, `A-Z`, `0-9`)
        /// - hyphens (`-`)
        /// - underscores (`_`)
        /// - plus signs (`+`)
        /// - periods (`.`)
        /// - at symbol (`@`)
        /// - pipe symbol (`|`)
        public let referenceId: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            type: EntityType,
            appId: String,
            referenceId: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.type = type
            self.appId = appId
            self.referenceId = referenceId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.type = try container.decode(EntityType.self, forKey: .type)
            self.appId = try container.decode(String.self, forKey: .appId)
            self.referenceId = try container.decode(String.self, forKey: .referenceId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.level, forKey: .level)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.appId, forKey: .appId)
            try container.encode(self.referenceId, forKey: .referenceId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case level
            case type
            case appId
            case referenceId
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case level
    }
}