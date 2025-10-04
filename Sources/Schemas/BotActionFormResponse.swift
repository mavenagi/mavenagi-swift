import Foundation

/// This response should be rendered as a form which users can submit. Upon submission call the `submitActionForm` API.
public struct BotActionFormResponse: Codable, Hashable, Sendable {
    /// The ID to use when submitting the form via the `submitActionForm` API.
    public let id: String
    /// The ID of the action that will be executed when the form is submitted.
    public let actionId: EntityIdWithoutAgent
    /// Text which should be displayed to the user at the top of the form. Provided in the user's language.
    public let formLabel: String
    /// The fields that should be displayed within the form.
    public let fields: [ActionFormField]
    /// Text that should be displayed to the user on the submit button. Provided in the user's language.
    public let submitLabel: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: String,
        actionId: EntityIdWithoutAgent,
        formLabel: String,
        fields: [ActionFormField],
        submitLabel: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.actionId = actionId
        self.formLabel = formLabel
        self.fields = fields
        self.submitLabel = submitLabel
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.actionId = try container.decode(EntityIdWithoutAgent.self, forKey: .actionId)
        self.formLabel = try container.decode(String.self, forKey: .formLabel)
        self.fields = try container.decode([ActionFormField].self, forKey: .fields)
        self.submitLabel = try container.decode(String.self, forKey: .submitLabel)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.actionId, forKey: .actionId)
        try container.encode(self.formLabel, forKey: .formLabel)
        try container.encode(self.fields, forKey: .fields)
        try container.encode(self.submitLabel, forKey: .submitLabel)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case actionId
        case formLabel
        case fields
        case submitLabel
    }
}