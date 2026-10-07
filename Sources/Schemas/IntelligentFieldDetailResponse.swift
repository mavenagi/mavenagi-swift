import Foundation

public struct IntelligentFieldDetailResponse: Codable, Hashable, Sendable {
    /// ID that uniquely identifies this intelligent field
    public let fieldId: EntityId
    /// Target entity type for evaluation. CONVERSATION is supported, and AGENT_USER is supported for agents with user-level intelligent fields enabled. The backend will return an error for other types.
    public let entityType: EntityType
    /// On a request, the agent variant to stage the write in. On a response, the variant the request named, if any; absent when it named none.
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
    /// Charters whose precondition references this intelligent field. A field referenced by
    /// an active precondition cannot be deactivated.
    public let referencingCharters: [CharterSummary]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        fieldId: EntityId,
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
        referencingCharters: [CharterSummary]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.fieldId = fieldId
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
        self.referencingCharters = referencingCharters
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fieldId = try container.decode(EntityId.self, forKey: .fieldId)
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
        self.referencingCharters = try container.decodeIfPresent([CharterSummary].self, forKey: .referencingCharters)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.fieldId, forKey: .fieldId)
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
        try container.encodeIfPresent(self.referencingCharters, forKey: .referencingCharters)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case fieldId
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
        case referencingCharters
    }
}