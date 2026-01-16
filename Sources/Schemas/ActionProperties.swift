import Foundation

public struct ActionProperties: Codable, Hashable, Sendable {
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
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        userInteractionRequired: Bool,
        buttonName: String? = nil,
        precondition: Precondition? = nil,
        userFormParameters: [ActionParameter],
        language: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.userInteractionRequired = userInteractionRequired
        self.buttonName = buttonName
        self.precondition = precondition
        self.userFormParameters = userFormParameters
        self.language = language
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userInteractionRequired = try container.decode(Bool.self, forKey: .userInteractionRequired)
        self.buttonName = try container.decodeIfPresent(String.self, forKey: .buttonName)
        self.precondition = try container.decodeIfPresent(Precondition.self, forKey: .precondition)
        self.userFormParameters = try container.decode([ActionParameter].self, forKey: .userFormParameters)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.userInteractionRequired, forKey: .userInteractionRequired)
        try container.encodeIfPresent(self.buttonName, forKey: .buttonName)
        try container.encodeIfPresent(self.precondition, forKey: .precondition)
        try container.encode(self.userFormParameters, forKey: .userFormParameters)
        try container.encodeIfPresent(self.language, forKey: .language)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case userInteractionRequired
        case buttonName
        case precondition
        case userFormParameters
        case language
    }
}