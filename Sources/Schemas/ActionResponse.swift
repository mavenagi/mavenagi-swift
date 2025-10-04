import Foundation

public struct ActionResponse: Codable, Hashable, Sendable {
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
    public let actionId: EntityId
    /// The instructions given to the LLM when determining whether to execute the action.
    /// This field defaults to the `description` field if not provided. Use the `patch` API to update.
    public let instructions: String?
    /// Determines whether the action is sent to the LLM as part of a conversation.
    /// 
    /// - `ALWAYS`: The action is always available for use in conversations, textual relevance is not considered.
    /// - `WHEN_RELEVANT`: The action is available only in conversations where the action is determined to be relevant to the user's question.
    /// - `NEVER`: The action is not available for use in conversations.
    public let llmInclusionStatus: LlmInclusionStatus
    /// The IDs of the segment that must be matched for the action to be relevant to a conversation.
    /// Segments are replacing inline preconditions - an Action may not have both an inline precondition and a segment.
    /// Inline precondition support will be removed in a future release.
    public let segmentId: EntityId?
    /// A human-readable explanation of the precondition associated with this action, if present.
    public let preconditionExplanation: String?
    /// Whether the action has been deleted. Deleted actions will not sent to the LLM nor returned in search results.
    public let deleted: Bool
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
        actionId: EntityId,
        instructions: String? = nil,
        llmInclusionStatus: LlmInclusionStatus,
        segmentId: EntityId? = nil,
        preconditionExplanation: String? = nil,
        deleted: Bool,
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
        self.instructions = instructions
        self.llmInclusionStatus = llmInclusionStatus
        self.segmentId = segmentId
        self.preconditionExplanation = preconditionExplanation
        self.deleted = deleted
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
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.userInteractionRequired, forKey: .userInteractionRequired)
        try container.encodeIfPresent(self.buttonName, forKey: .buttonName)
        try container.encodeIfPresent(self.precondition, forKey: .precondition)
        try container.encode(self.userFormParameters, forKey: .userFormParameters)
        try container.encodeIfPresent(self.language, forKey: .language)
        try container.encode(self.actionId, forKey: .actionId)
        try container.encodeIfPresent(self.instructions, forKey: .instructions)
        try container.encode(self.llmInclusionStatus, forKey: .llmInclusionStatus)
        try container.encodeIfPresent(self.segmentId, forKey: .segmentId)
        try container.encodeIfPresent(self.preconditionExplanation, forKey: .preconditionExplanation)
        try container.encode(self.deleted, forKey: .deleted)
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
        case instructions
        case llmInclusionStatus
        case segmentId
        case preconditionExplanation
        case deleted
    }
}