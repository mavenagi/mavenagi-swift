import Foundation

public struct ActionRequest: Codable, Hashable, Sendable {
    /// The name of the action. This is displayed to the end user as part of forms when user interaction is required. It is also used to help Maven decide if the action is relevant to a conversation.
    public let name: String
    /// The description of the action. Must be less than 1024 characters. This helps Maven decide if the action is relevant to a conversation and is not displayed directly to the end user. Descriptions are used by the LLM.
    public let description: String
    /// Whether the action requires user interaction to execute. If false, and all of the required action parameters are known, the LLM may call the action automatically. If true, an conversations ask call will return a BotActionFormResponse which must be submitted by an API caller. API callers must display a button with the buttonName label to confirm the user's intent.
    public let userInteractionRequired: Bool
    /// When user interaction is required, the name of the button that is shown to the end user to confirm execution of the action. Defaults to "Submit" if not supplied.
    public let buttonName: String?
    /// The preconditions that must be met for an action to be relevant to a conversation. Can be used to restrict actions to certain types of users.
    public let precondition: Precondition?
    /// The parameters that the action uses as input. An action will only be executed when all of the required parameters are provided. During execution, actions all have access to the full Conversation and User objects. Parameter values may be inferred from the user's conversation by the LLM.
    public let userFormParameters: [ActionParameter]
    /// The ISO 639-1 code for the language used in all fields of this action. Will be derived using the description's text if not specified.
    public let language: String?
    /// ID that uniquely identifies this action
    public let actionId: EntityIdBase
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        description: String,
        userInteractionRequired: Bool,
        buttonName: String? = nil,
        precondition: Precondition? = nil,
        userFormParameters: [ActionParameter],
        language: String? = nil,
        actionId: EntityIdBase,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.description = description
        self.userInteractionRequired = userInteractionRequired
        self.buttonName = buttonName
        self.precondition = precondition
        self.userFormParameters = userFormParameters
        self.language = language
        self.actionId = actionId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.userInteractionRequired = try container.decode(Bool.self, forKey: .userInteractionRequired)
        self.buttonName = try container.decodeIfPresent(String.self, forKey: .buttonName)
        self.precondition = try container.decodeIfPresent(Precondition.self, forKey: .precondition)
        self.userFormParameters = try container.decode([ActionParameter].self, forKey: .userFormParameters)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.actionId = try container.decode(EntityIdBase.self, forKey: .actionId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.userInteractionRequired, forKey: .userInteractionRequired)
        try container.encodeIfPresent(self.buttonName, forKey: .buttonName)
        try container.encodeIfPresent(self.precondition, forKey: .precondition)
        try container.encode(self.userFormParameters, forKey: .userFormParameters)
        try container.encodeIfPresent(self.language, forKey: .language)
        try container.encode(self.actionId, forKey: .actionId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case description
        case userInteractionRequired
        case buttonName
        case precondition
        case userFormParameters
        case language
        case actionId
    }
}