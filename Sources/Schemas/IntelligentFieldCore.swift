import Foundation

/// The minimal set of fields describing an intelligent field's content, shared by both the
/// field's own resource representation (IntelligentFieldBase) and a single staged edit's
/// payload (IntelligentFieldPayload) -- kept as one type so the two don't drift out of sync on
/// what "the same" field content looks like.
public struct IntelligentFieldCore: Codable, Hashable, Sendable {
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
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        description: String? = nil,
        validationType: IntelligentFieldType,
        definition: String,
        enumOptions: [EnumOption]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.description = description
        self.validationType = validationType
        self.definition = definition
        self.enumOptions = enumOptions
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.validationType = try container.decode(IntelligentFieldType.self, forKey: .validationType)
        self.definition = try container.decode(String.self, forKey: .definition)
        self.enumOptions = try container.decodeIfPresent([EnumOption].self, forKey: .enumOptions)
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
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case description
        case validationType
        case definition
        case enumOptions
    }
}