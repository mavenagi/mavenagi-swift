import Foundation

public struct ActionParameter: Codable, Hashable, Sendable {
    /// The ID field will be used when parameters are supplied to `executeAction`.
    public let id: String
    /// The title of the field that will be shown on action forms.
    public let label: String
    /// A longer description of the field which will be shown in smaller text near the label on action forms.
    public let description: String
    /// Whether the field is required for action execution.
    public let required: Bool
    /// When user interaction is required, whether this parameter should be excluded from forms. Hidden parameters are not displayed to users but their values are still populated by the LLM and sent to actions. Defaults to false.
    public let hidden: Bool?
    /// The parameter type. Values provided to `executeAction` will conform to this type. Defaults to `STRING`.
    public let type: ActionParameterType?
    /// Restricts the action parameter to only the options in this list. Valid for type `STRING`, `BOOLEAN`, and `NUMBER`. Should not be used when type is `SCHEMA`.
    public let enumOptions: [ActionEnumOption]?
    /// JSON schema for validating the parameter value. Only valid when type is `SCHEMA`.
    /// 
    /// **Schema Requirements:**
    /// - Root type must be "object" - The top-level schema must define an object type
    /// - Supported types: string, number, boolean, integer, object, array, enum, anyOf
    /// - Unsupported features: oneOf, allOf, const, not, if/then/else, pattern, maxLength, minLength
    /// - Required fields: All fields must be required (no optional properties)
    /// - Additional properties: Must be set to false
    /// 
    /// **Limits:**
    /// - Maximum nesting depth: 5 levels
    /// - Maximum total properties: 100
    /// - Maximum total string length: 15,000 characters
    /// - Maximum total enum values: 500
    public let schema: String?
    /// OAuth configuration required to start an OAuth authorization flow when this parameter's type is `OAUTH`.
    public let oauthConfiguration: ActionOAuthConfiguration?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: String,
        label: String,
        description: String,
        required: Bool,
        hidden: Bool? = nil,
        type: ActionParameterType? = nil,
        enumOptions: [ActionEnumOption]? = nil,
        schema: String? = nil,
        oauthConfiguration: ActionOAuthConfiguration? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.label = label
        self.description = description
        self.required = required
        self.hidden = hidden
        self.type = type
        self.enumOptions = enumOptions
        self.schema = schema
        self.oauthConfiguration = oauthConfiguration
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.label = try container.decode(String.self, forKey: .label)
        self.description = try container.decode(String.self, forKey: .description)
        self.required = try container.decode(Bool.self, forKey: .required)
        self.hidden = try container.decodeIfPresent(Bool.self, forKey: .hidden)
        self.type = try container.decodeIfPresent(ActionParameterType.self, forKey: .type)
        self.enumOptions = try container.decodeIfPresent([ActionEnumOption].self, forKey: .enumOptions)
        self.schema = try container.decodeIfPresent(String.self, forKey: .schema)
        self.oauthConfiguration = try container.decodeIfPresent(ActionOAuthConfiguration.self, forKey: .oauthConfiguration)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.label, forKey: .label)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.required, forKey: .required)
        try container.encodeIfPresent(self.hidden, forKey: .hidden)
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.enumOptions, forKey: .enumOptions)
        try container.encodeIfPresent(self.schema, forKey: .schema)
        try container.encodeIfPresent(self.oauthConfiguration, forKey: .oauthConfiguration)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case label
        case description
        case required
        case hidden
        case type
        case enumOptions
        case schema
        case oauthConfiguration
    }
}