import Foundation

public struct IntelligentFieldBase: Codable, Hashable, Sendable {
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
    /// Target entity type for evaluation. CONVERSATION is supported, and AGENT_USER is supported for agents with user-level intelligent fields enabled. The backend will return an error for other types.
    public let entityType: EntityType
    /// On a request, the agent variant to stage the write in. On a response, the variant the request named, if any; absent when it named none.
    public let variantId: EntityIdWithoutAgent?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        validationType: IntelligentFieldType,
        definition: String,
        enumOptions: [EnumOption]? = nil,
        entityType: EntityType,
        variantId: EntityIdWithoutAgent? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.validationType = validationType
        self.definition = definition
        self.enumOptions = enumOptions
        self.entityType = entityType
        self.variantId = variantId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.validationType = try container.decode(IntelligentFieldType.self, forKey: .validationType)
        self.definition = try container.decode(String.self, forKey: .definition)
        self.enumOptions = try container.decodeIfPresent([EnumOption].self, forKey: .enumOptions)
        self.entityType = try container.decode(EntityType.self, forKey: .entityType)
        self.variantId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .variantId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.validationType, forKey: .validationType)
        try container.encode(self.definition, forKey: .definition)
        try container.encodeIfPresent(self.enumOptions, forKey: .enumOptions)
        try container.encode(self.entityType, forKey: .entityType)
        try container.encodeIfPresent(self.variantId, forKey: .variantId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case validationType
        case definition
        case enumOptions
        case entityType
        case variantId
    }
}