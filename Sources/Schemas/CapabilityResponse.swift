import Foundation

/// One of an agent's capabilities, of whichever kind. Each variant is the very type that
/// capability's own API returns, so nothing is redefined here.
/// 
/// The discriminant is `capabilityType` rather than `type` because an event trigger already has
/// a `type` of its own. Naming it apart is what lets each variant keep its own fields unchanged.
public enum CapabilityResponse: Codable, Hashable, Sendable {
    case action(Action)
    case conversationKickoff(ConversationKickoff)
    case intelligentField(IntelligentField)
    case trigger(Trigger)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .capabilityType)
        switch discriminant {
        case "ACTION":
            self = .action(try Action(from: decoder))
        case "CONVERSATION_KICKOFF":
            self = .conversationKickoff(try ConversationKickoff(from: decoder))
        case "INTELLIGENT_FIELD":
            self = .intelligentField(try IntelligentField(from: decoder))
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
        case .conversationKickoff(let data):
            try data.encode(to: encoder)
        case .intelligentField(let data):
            try data.encode(to: encoder)
        case .trigger(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Action: Codable, Hashable, Sendable {
        public let capabilityType: String = "ACTION"
        /// Whether the action requires user interaction to execute. If false, and all of the required action parameters are known, the LLM may call the action automatically. If true, an conversations ask call will return a BotActionFormResponse which must be submitted by an API caller. API callers must display a button with the buttonName label to confirm the user's intent.
        public let userInteractionRequired: Bool
        /// When user interaction is required, the name of the button that is shown to the end user to confirm execution of the action. Defaults to "Submit" if not supplied.
        public let buttonName: String?
        /// Deprecated. Superseded by charters, which determine when knowledge bases and actions apply. Has no effect for agents using charters.
        /// 
        /// The preconditions that must be met for an action to be relevant to a conversation.
        public let precondition: Precondition?
        /// The parameters that the action uses as input. An action will only be executed when all of the required parameters are provided. During execution, actions all have access to the full Conversation and User objects. Parameter values may be inferred from the user's conversation by the LLM.
        public let userFormParameters: [ActionParameter]
        /// The ISO 639-1 code for the language used in all fields of this action. Will be derived using the description's text if not specified.
        public let language: String?
        /// Whether executing this action causes side effects. Absent means the action has never
        /// declared either way.
        /// 
        /// This value is informational only. It does not yet affect action execution.
        public let sideEffects: SideEffects?
        /// The capability's display name, shown to whoever manages the agent. A trigger registered
        /// without one is named after the app that registered it and the event it fires on.
        public let name: String
        /// What the capability does. Shown to whoever manages the agent, and for the types the LLM
        /// can choose between, used to decide when the capability applies.
        public let description: String?
        /// When the capability was created.
        public let createdAt: Date
        /// When the capability was last modified.
        public let updatedAt: Date
        /// Whether the agent uses this capability, and whether it still exists.
        public let status: CapabilityStatus
        /// ID that uniquely identifies this action
        public let actionId: EntityId
        /// The instructions given to the LLM when determining whether to execute the action.
        /// This field defaults to the `description` field if not provided. Use the `patch` API to update.
        public let instructions: String?
        /// Deprecated. Superseded by `status`, which says the same thing for every capability type.
        /// 
        /// Determines whether the action is sent to the LLM as part of a conversation.
        /// 
        /// - `ALWAYS`: The action is always available for use in conversations, textual relevance is not considered.
        /// - `WHEN_RELEVANT`: The action is available only in conversations where the action is determined to be relevant to the user's question.
        /// - `NEVER`: The action is not available for use in conversations.
        public let llmInclusionStatus: LlmInclusionStatus
        /// Deprecated. Superseded by charters, which determine when knowledge bases and actions apply. Has no effect for agents using charters.
        /// 
        /// The ID of the segment that must be matched for the action to be relevant to a conversation.
        public let segmentId: EntityId?
        /// No longer populated. This field is always absent and will be removed in a future release.
        public let preconditionExplanation: String?
        /// Deprecated. Superseded by `status`, where a deleted action is `DELETED`.
        /// 
        /// Whether the action has been deleted. Deleted actions will not sent to the LLM nor returned in search results.
        public let deleted: Bool
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            userInteractionRequired: Bool,
            buttonName: String? = nil,
            precondition: Precondition? = nil,
            userFormParameters: [ActionParameter],
            language: String? = nil,
            sideEffects: SideEffects? = nil,
            name: String,
            description: String? = nil,
            createdAt: Date,
            updatedAt: Date,
            status: CapabilityStatus,
            actionId: EntityId,
            instructions: String? = nil,
            llmInclusionStatus: LlmInclusionStatus,
            segmentId: EntityId? = nil,
            preconditionExplanation: String? = nil,
            deleted: Bool,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.userInteractionRequired = userInteractionRequired
            self.buttonName = buttonName
            self.precondition = precondition
            self.userFormParameters = userFormParameters
            self.language = language
            self.sideEffects = sideEffects
            self.name = name
            self.description = description
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.status = status
            self.actionId = actionId
            self.instructions = instructions
            self.llmInclusionStatus = llmInclusionStatus
            self.segmentId = segmentId
            self.preconditionExplanation = preconditionExplanation
            self.deleted = deleted
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.userInteractionRequired = try container.decode(Bool.self, forKey: .userInteractionRequired)
            self.buttonName = try container.decodeIfPresent(String.self, forKey: .buttonName)
            self.precondition = try container.decodeIfPresent(Precondition.self, forKey: .precondition)
            self.userFormParameters = try container.decode([ActionParameter].self, forKey: .userFormParameters)
            self.language = try container.decodeIfPresent(String.self, forKey: .language)
            self.sideEffects = try container.decodeIfPresent(SideEffects.self, forKey: .sideEffects)
            self.name = try container.decode(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.createdAt = try container.decode(Date.self, forKey: .createdAt)
            self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
            self.status = try container.decode(CapabilityStatus.self, forKey: .status)
            self.actionId = try container.decode(EntityId.self, forKey: .actionId)
            self.instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
            self.llmInclusionStatus = try container.decode(LlmInclusionStatus.self, forKey: .llmInclusionStatus)
            self.segmentId = try container.decodeIfPresent(EntityId.self, forKey: .segmentId)
            self.preconditionExplanation = try container.decodeIfPresent(String.self, forKey: .preconditionExplanation)
            self.deleted = try container.decode(Bool.self, forKey: .deleted)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.capabilityType, forKey: .capabilityType)
            try container.encode(self.userInteractionRequired, forKey: .userInteractionRequired)
            try container.encodeIfPresent(self.buttonName, forKey: .buttonName)
            try container.encodeIfPresent(self.precondition, forKey: .precondition)
            try container.encode(self.userFormParameters, forKey: .userFormParameters)
            try container.encodeIfPresent(self.language, forKey: .language)
            try container.encodeIfPresent(self.sideEffects, forKey: .sideEffects)
            try container.encode(self.name, forKey: .name)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encode(self.createdAt, forKey: .createdAt)
            try container.encode(self.updatedAt, forKey: .updatedAt)
            try container.encode(self.status, forKey: .status)
            try container.encode(self.actionId, forKey: .actionId)
            try container.encodeIfPresent(self.instructions, forKey: .instructions)
            try container.encode(self.llmInclusionStatus, forKey: .llmInclusionStatus)
            try container.encodeIfPresent(self.segmentId, forKey: .segmentId)
            try container.encodeIfPresent(self.preconditionExplanation, forKey: .preconditionExplanation)
            try container.encode(self.deleted, forKey: .deleted)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case capabilityType
            case userInteractionRequired
            case buttonName
            case precondition
            case userFormParameters
            case language
            case sideEffects
            case name
            case description
            case createdAt
            case updatedAt
            case status
            case actionId
            case instructions
            case llmInclusionStatus
            case segmentId
            case preconditionExplanation
            case deleted
        }
    }

    public struct Trigger: Codable, Hashable, Sendable {
        public let capabilityType: String = "TRIGGER"
        /// The type of event trigger this app wishes to handle.
        /// 
        /// Conversation triggers fire when a conversation is created, after each additional message, and upon deletion events.
        /// There is a small delay before trigger execution to allow time for conversation analysis to complete.
        /// 
        /// Events are immutable, so an event trigger fires immediately after the event is created.
        /// 
        /// Inbox triggers fire when an inbox item is created or updated.
        public let type: EventTriggerType
        /// The capability's display name, shown to whoever manages the agent. A trigger registered
        /// without one is named after the app that registered it and the event it fires on.
        public let name: String
        /// What the capability does. Shown to whoever manages the agent, and for the types the LLM
        /// can choose between, used to decide when the capability applies.
        public let description: String?
        /// When the capability was created.
        public let createdAt: Date
        /// When the capability was last modified.
        public let updatedAt: Date
        /// Whether the agent uses this capability, and whether it still exists.
        public let status: CapabilityStatus
        /// ID that uniquely identifies this event trigger
        public let triggerId: EntityId
        /// Deprecated. Superseded by `status`, which says the same thing for every capability type.
        /// 
        /// Whether this trigger will be called by Maven.
        public let enabled: Bool
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            type: EventTriggerType,
            name: String,
            description: String? = nil,
            createdAt: Date,
            updatedAt: Date,
            status: CapabilityStatus,
            triggerId: EntityId,
            enabled: Bool,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.type = type
            self.name = name
            self.description = description
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.status = status
            self.triggerId = triggerId
            self.enabled = enabled
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.type = try container.decode(EventTriggerType.self, forKey: .type)
            self.name = try container.decode(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.createdAt = try container.decode(Date.self, forKey: .createdAt)
            self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
            self.status = try container.decode(CapabilityStatus.self, forKey: .status)
            self.triggerId = try container.decode(EntityId.self, forKey: .triggerId)
            self.enabled = try container.decode(Bool.self, forKey: .enabled)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.capabilityType, forKey: .capabilityType)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.name, forKey: .name)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encode(self.createdAt, forKey: .createdAt)
            try container.encode(self.updatedAt, forKey: .updatedAt)
            try container.encode(self.status, forKey: .status)
            try container.encode(self.triggerId, forKey: .triggerId)
            try container.encode(self.enabled, forKey: .enabled)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case capabilityType
            case type
            case name
            case description
            case createdAt
            case updatedAt
            case status
            case triggerId
            case enabled
        }
    }

    public struct IntelligentField: Codable, Hashable, Sendable {
        public let capabilityType: String = "INTELLIGENT_FIELD"
        /// Target entity type for evaluation. Only CONVERSATION is supported at this time. The backend will return an error for other types.
        public let entityType: EntityType
        /// ID of the agent variant this field belongs to, if applicable
        public let variantId: EntityIdWithoutAgent?
        /// The type of value this field holds. It constrains the schema the LLM is asked to fill
        /// and the JSON type of the computed `value`.
        /// 
        /// - STRING / MULTILINE: a single string
        /// - MULTI_SELECT: a list of strings
        /// - BOOLEAN: `true` or `false`
        /// - NUMBER: a number
        /// 
        /// For a single select, use STRING or NUMBER together with `enumOptions`.
        public let validationType: IntelligentFieldType
        /// Definition used by the LLM when generating this field's value
        public let definition: String
        /// The finite set of values this field may take. Omit to let the LLM produce any value of
        /// the `validationType`. Options may be added later with the patch endpoint, but not removed.
        public let enumOptions: [EnumOption]?
        /// The capability's display name, shown to whoever manages the agent. A trigger registered
        /// without one is named after the app that registered it and the event it fires on.
        public let name: String
        /// What the capability does. Shown to whoever manages the agent, and for the types the LLM
        /// can choose between, used to decide when the capability applies.
        public let description: String?
        /// When the capability was created.
        public let createdAt: Date
        /// When the capability was last modified.
        public let updatedAt: Date
        /// Whether the agent uses this capability, and whether it still exists.
        public let status: CapabilityStatus
        /// ID that uniquely identifies this intelligent field
        public let fieldId: EntityId
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            entityType: EntityType,
            variantId: EntityIdWithoutAgent? = nil,
            validationType: IntelligentFieldType,
            definition: String,
            enumOptions: [EnumOption]? = nil,
            name: String,
            description: String? = nil,
            createdAt: Date,
            updatedAt: Date,
            status: CapabilityStatus,
            fieldId: EntityId,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.entityType = entityType
            self.variantId = variantId
            self.validationType = validationType
            self.definition = definition
            self.enumOptions = enumOptions
            self.name = name
            self.description = description
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.status = status
            self.fieldId = fieldId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.entityType = try container.decode(EntityType.self, forKey: .entityType)
            self.variantId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .variantId)
            self.validationType = try container.decode(IntelligentFieldType.self, forKey: .validationType)
            self.definition = try container.decode(String.self, forKey: .definition)
            self.enumOptions = try container.decodeIfPresent([EnumOption].self, forKey: .enumOptions)
            self.name = try container.decode(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.createdAt = try container.decode(Date.self, forKey: .createdAt)
            self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
            self.status = try container.decode(CapabilityStatus.self, forKey: .status)
            self.fieldId = try container.decode(EntityId.self, forKey: .fieldId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.capabilityType, forKey: .capabilityType)
            try container.encode(self.entityType, forKey: .entityType)
            try container.encodeIfPresent(self.variantId, forKey: .variantId)
            try container.encode(self.validationType, forKey: .validationType)
            try container.encode(self.definition, forKey: .definition)
            try container.encodeIfPresent(self.enumOptions, forKey: .enumOptions)
            try container.encode(self.name, forKey: .name)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encode(self.createdAt, forKey: .createdAt)
            try container.encode(self.updatedAt, forKey: .updatedAt)
            try container.encode(self.status, forKey: .status)
            try container.encode(self.fieldId, forKey: .fieldId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case capabilityType
            case entityType
            case variantId
            case validationType
            case definition
            case enumOptions
            case name
            case description
            case createdAt
            case updatedAt
            case status
            case fieldId
        }
    }

    public struct ConversationKickoff: Codable, Hashable, Sendable {
        public let capabilityType: String = "CONVERSATION_KICKOFF"
        /// The capability's display name, shown to whoever manages the agent. A trigger registered
        /// without one is named after the app that registered it and the event it fires on.
        public let name: String
        /// What the capability does. Shown to whoever manages the agent, and for the types the LLM
        /// can choose between, used to decide when the capability applies.
        public let description: String?
        /// When the capability was created.
        public let createdAt: Date
        /// When the capability was last modified.
        public let updatedAt: Date
        /// Whether the agent uses this capability, and whether it still exists.
        public let status: CapabilityStatus
        /// ID that uniquely identifies this Conversation Kickoff.
        public let kickoffId: EntityId
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            name: String,
            description: String? = nil,
            createdAt: Date,
            updatedAt: Date,
            status: CapabilityStatus,
            kickoffId: EntityId,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.name = name
            self.description = description
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.status = status
            self.kickoffId = kickoffId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.createdAt = try container.decode(Date.self, forKey: .createdAt)
            self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
            self.status = try container.decode(CapabilityStatus.self, forKey: .status)
            self.kickoffId = try container.decode(EntityId.self, forKey: .kickoffId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.capabilityType, forKey: .capabilityType)
            try container.encode(self.name, forKey: .name)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encode(self.createdAt, forKey: .createdAt)
            try container.encode(self.updatedAt, forKey: .updatedAt)
            try container.encode(self.status, forKey: .status)
            try container.encode(self.kickoffId, forKey: .kickoffId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case capabilityType
            case name
            case description
            case createdAt
            case updatedAt
            case status
            case kickoffId
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case capabilityType
    }
}