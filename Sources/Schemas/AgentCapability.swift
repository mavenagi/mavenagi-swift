import Foundation

public enum AgentCapability: Codable, Hashable, Sendable {
    case action(Action)
    case trigger(Trigger)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .type)
        switch discriminant {
        case "ACTION":
            self = .action(try Action(from: decoder))
        case "TRIGGER":
            self = .trigger(try Trigger(from: decoder))
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
        case .trigger(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Action: Codable, Hashable, Sendable {
        public let type: String = "ACTION"
        public let name: String
        public let description: Nullable<String>
        /// Timestamp when the capability was created
        public let createdAt: Date
        /// Whether this capability will be called by Maven.
        public let enabled: Bool
        public let version: Int
        /// ID that uniquely identifies this capability
        public let capabilityId: EntityId
        public let userInteractionRequired: Bool
        /// When user interaction is required, the name of the button that is shown to the end user to confirm execution of the action. Defaults to "Submit" if not supplied.
        public let buttonName: String?
        /// The parameters that the action uses as input. An action will only be executed when all of the required parameters are provided. Parameter values may be inferred from the user's conversation by the LLM.
        public let userFormParameters: [ActionParameter]
        public let precondition: Precondition?
        public let descriptionOverride: String?
        /// A human-readable explanation of the precondition associated with this action, if present.
        public let preconditionExplanation: String?
        public let pinned: Bool
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            name: String,
            description: Nullable<String>,
            createdAt: Date,
            enabled: Bool,
            version: Int,
            capabilityId: EntityId,
            userInteractionRequired: Bool,
            buttonName: String? = nil,
            userFormParameters: [ActionParameter],
            precondition: Precondition? = nil,
            descriptionOverride: String? = nil,
            preconditionExplanation: String? = nil,
            pinned: Bool,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.name = name
            self.description = description
            self.createdAt = createdAt
            self.enabled = enabled
            self.version = version
            self.capabilityId = capabilityId
            self.userInteractionRequired = userInteractionRequired
            self.buttonName = buttonName
            self.userFormParameters = userFormParameters
            self.precondition = precondition
            self.descriptionOverride = descriptionOverride
            self.preconditionExplanation = preconditionExplanation
            self.pinned = pinned
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.description = try container.decode(Nullable<String>.self, forKey: .description)
            self.createdAt = try container.decode(Date.self, forKey: .createdAt)
            self.enabled = try container.decode(Bool.self, forKey: .enabled)
            self.version = try container.decode(Int.self, forKey: .version)
            self.capabilityId = try container.decode(EntityId.self, forKey: .capabilityId)
            self.userInteractionRequired = try container.decode(Bool.self, forKey: .userInteractionRequired)
            self.buttonName = try container.decodeIfPresent(String.self, forKey: .buttonName)
            self.userFormParameters = try container.decode([ActionParameter].self, forKey: .userFormParameters)
            self.precondition = try container.decodeIfPresent(Precondition.self, forKey: .precondition)
            self.descriptionOverride = try container.decodeIfPresent(String.self, forKey: .descriptionOverride)
            self.preconditionExplanation = try container.decodeIfPresent(String.self, forKey: .preconditionExplanation)
            self.pinned = try container.decode(Bool.self, forKey: .pinned)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.name, forKey: .name)
            try container.encode(self.description, forKey: .description)
            try container.encode(self.createdAt, forKey: .createdAt)
            try container.encode(self.enabled, forKey: .enabled)
            try container.encode(self.version, forKey: .version)
            try container.encode(self.capabilityId, forKey: .capabilityId)
            try container.encode(self.userInteractionRequired, forKey: .userInteractionRequired)
            try container.encodeIfPresent(self.buttonName, forKey: .buttonName)
            try container.encode(self.userFormParameters, forKey: .userFormParameters)
            try container.encodeIfPresent(self.precondition, forKey: .precondition)
            try container.encodeIfPresent(self.descriptionOverride, forKey: .descriptionOverride)
            try container.encodeIfPresent(self.preconditionExplanation, forKey: .preconditionExplanation)
            try container.encode(self.pinned, forKey: .pinned)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case name
            case description
            case createdAt
            case enabled
            case version
            case capabilityId
            case userInteractionRequired
            case buttonName
            case userFormParameters
            case precondition
            case descriptionOverride
            case preconditionExplanation
            case pinned
        }
    }

    public struct Trigger: Codable, Hashable, Sendable {
        public let type: String = "TRIGGER"
        public let name: String
        public let description: Nullable<String>
        /// Timestamp when the capability was created
        public let createdAt: Date
        /// Whether this capability will be called by Maven.
        public let enabled: Bool
        public let version: Int
        /// ID that uniquely identifies this capability
        public let capabilityId: EntityId
        public let triggerType: TriggerType
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            name: String,
            description: Nullable<String>,
            createdAt: Date,
            enabled: Bool,
            version: Int,
            capabilityId: EntityId,
            triggerType: TriggerType,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.name = name
            self.description = description
            self.createdAt = createdAt
            self.enabled = enabled
            self.version = version
            self.capabilityId = capabilityId
            self.triggerType = triggerType
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.description = try container.decode(Nullable<String>.self, forKey: .description)
            self.createdAt = try container.decode(Date.self, forKey: .createdAt)
            self.enabled = try container.decode(Bool.self, forKey: .enabled)
            self.version = try container.decode(Int.self, forKey: .version)
            self.capabilityId = try container.decode(EntityId.self, forKey: .capabilityId)
            self.triggerType = try container.decode(TriggerType.self, forKey: .triggerType)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.name, forKey: .name)
            try container.encode(self.description, forKey: .description)
            try container.encode(self.createdAt, forKey: .createdAt)
            try container.encode(self.enabled, forKey: .enabled)
            try container.encode(self.version, forKey: .version)
            try container.encode(self.capabilityId, forKey: .capabilityId)
            try container.encode(self.triggerType, forKey: .triggerType)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case name
            case description
            case createdAt
            case enabled
            case version
            case capabilityId
            case triggerType
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}