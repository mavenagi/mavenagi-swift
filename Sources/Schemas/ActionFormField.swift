import Foundation

public struct ActionFormField: Codable, Hashable, Sendable {
    /// The ID field should be used as the key in the `submitActionForm` API.
    public let id: String
    /// The title of the field to show on the form. Provided in the user's language.
    public let label: String
    /// A longer description of the field which should be shown in smaller text near the label. Provided in the user's language.
    public let description: String
    /// Whether the field is required for the action. Client side validation is recommended for an improved user experience.
    public let required: Bool
    /// A value for the field provided by the LLM. All form fields should default to this value if present.
    public let suggestion: JSONValue?
    /// Describes how the action field should be validated. Client side validation is recommended but not required. | If `enumOptions` are provided, using a dropdown or radio field is preferred. Otherwise, if the `type` is `BOOLEAN` a checkbox is preferred. | Fallback to a text input.
    public let type: ActionParameterType
    /// The options that should be shown to the user as a dropdown or radio.
    public let enumOptions: [ActionEnumOption]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: String,
        label: String,
        description: String,
        required: Bool,
        suggestion: JSONValue? = nil,
        type: ActionParameterType,
        enumOptions: [ActionEnumOption]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.label = label
        self.description = description
        self.required = required
        self.suggestion = suggestion
        self.type = type
        self.enumOptions = enumOptions
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.label = try container.decode(String.self, forKey: .label)
        self.description = try container.decode(String.self, forKey: .description)
        self.required = try container.decode(Bool.self, forKey: .required)
        self.suggestion = try container.decodeIfPresent(JSONValue.self, forKey: .suggestion)
        self.type = try container.decode(ActionParameterType.self, forKey: .type)
        self.enumOptions = try container.decodeIfPresent([ActionEnumOption].self, forKey: .enumOptions)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.label, forKey: .label)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.required, forKey: .required)
        try container.encodeIfPresent(self.suggestion, forKey: .suggestion)
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.enumOptions, forKey: .enumOptions)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case label
        case description
        case required
        case suggestion
        case type
        case enumOptions
    }
}