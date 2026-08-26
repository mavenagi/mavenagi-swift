import Foundation

public struct IntelligentFieldBase: Codable, Hashable, Sendable {
    /// Display name for the intelligent field
    public let name: String
    /// A plain text description of the intelligent field.
    public let description: String?
    /// Result type hint used for schema generation, UI, and validation.
    /// 
    /// - STRING / MULTILINE: single string value
    /// - MULTI_SELECT: multiple values
    /// - BOOLEAN: boolean value
    /// - NUMBER: numeric value
    /// 
    /// Note: for single select, use STRING/NUMBER with a list of enumOptions.
    public let validationType: IntelligentFieldType
    /// Definition used by the LLM when generating this field's value
    public let definition: String
    /// Optional enum options for STRING/MULTILINE/NUMBER when a finite set is desired
    public let enumOptions: [EnumOption]?
    /// Target entity type for evaluation. Only CONVERSATION is supported at this time. The backend will return an error for other types.
    public let entityType: EntityType
    /// ID of the agent variant that created this field, if applicable
    public let variantId: EntityIdWithoutAgent?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        description: String? = nil,
        validationType: IntelligentFieldType,
        definition: String,
        enumOptions: [EnumOption]? = nil,
        entityType: EntityType,
        variantId: EntityIdWithoutAgent? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.description = description
        self.validationType = validationType
        self.definition = definition
        self.enumOptions = enumOptions
        self.entityType = entityType
        self.variantId = variantId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
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
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encode(self.validationType, forKey: .validationType)
        try container.encode(self.definition, forKey: .definition)
        try container.encodeIfPresent(self.enumOptions, forKey: .enumOptions)
        try container.encode(self.entityType, forKey: .entityType)
        try container.encodeIfPresent(self.variantId, forKey: .variantId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case description
        case validationType
        case definition
        case enumOptions
        case entityType
        case variantId
    }
}