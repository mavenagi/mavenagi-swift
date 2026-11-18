import Foundation

public struct AgentPrompting: Codable, Hashable, Sendable {
    /// Deprecated. Superseded by charters, which determine agent behavior per round. Has no effect for agents using charters.
    public let persona: LlmPersona
    /// Deprecated. Superseded by charters, which determine agent behavior per round. Has no effect for agents using charters.
    /// 
    /// Shown in Agent Designer as "Additional persona instructions".
    public let additionalPromptText: String?
    /// Deprecated. Use `categoryIntelligentFieldId` instead. Not supported on new agents, and ignored while `categoryIntelligentFieldId` is set.
    /// 
    /// LLM prompt for category generation.
    /// 
    /// Use this to specify a fixed set of categories that an LLM should choose from when analyzing a conversation.
    /// When not set uses a default prompt which gives the LLM flexibility to determine appropriate categories on its own.
    /// 
    /// Shown in Agent Designer as "Category prompt override".
    public let categoryGenerationPromptText: String?
    /// Instructions to an LLM that writes the reply when the user's message is blocked for harmful content (hate, self-harm, sexual or violence). The LLM sees only these instructions and the blocked message, not the agent's charters, knowledge or earlier messages. To send fixed wording, say so in the instructions, for example `Always reply with exactly: "…"`.
    /// 
    /// A message flagged as a prompt attack always gets the default reply, even when it was also flagged for harmful content. So does every blocked message while this is not set.
    /// 
    /// Shown in Agent Designer as "Content Safety Violation Message".
    /// 
    /// Omitted while `CONTENT_SAFETY_VIOLATION_RESPONSE_PROMPT_TEXT` is in `getVersionedEntityTypes`; read it through `getVersionedSettings`.
    public let contentSafetyViolationResponsePromptText: String?
    /// Deprecated. Superseded by charters, which determine agent behavior per round. Has no effect for agents using charters.
    /// 
    /// Return the system fallback message on all questions that have no relevant knowledge bases or actions.
    /// 
    /// Shown in Agent Designer as "Only return answers for existing knowledge".
    public let rejectQuestionsWithoutKnowledge: Bool
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        persona: LlmPersona,
        additionalPromptText: String? = nil,
        categoryGenerationPromptText: String? = nil,
        contentSafetyViolationResponsePromptText: String? = nil,
        rejectQuestionsWithoutKnowledge: Bool,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.persona = persona
        self.additionalPromptText = additionalPromptText
        self.categoryGenerationPromptText = categoryGenerationPromptText
        self.contentSafetyViolationResponsePromptText = contentSafetyViolationResponsePromptText
        self.rejectQuestionsWithoutKnowledge = rejectQuestionsWithoutKnowledge
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.persona = try container.decode(LlmPersona.self, forKey: .persona)
        self.additionalPromptText = try container.decodeIfPresent(String.self, forKey: .additionalPromptText)
        self.categoryGenerationPromptText = try container.decodeIfPresent(String.self, forKey: .categoryGenerationPromptText)
        self.contentSafetyViolationResponsePromptText = try container.decodeIfPresent(String.self, forKey: .contentSafetyViolationResponsePromptText)
        self.rejectQuestionsWithoutKnowledge = try container.decode(Bool.self, forKey: .rejectQuestionsWithoutKnowledge)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.persona, forKey: .persona)
        try container.encodeIfPresent(self.additionalPromptText, forKey: .additionalPromptText)
        try container.encodeIfPresent(self.categoryGenerationPromptText, forKey: .categoryGenerationPromptText)
        try container.encodeIfPresent(self.contentSafetyViolationResponsePromptText, forKey: .contentSafetyViolationResponsePromptText)
        try container.encode(self.rejectQuestionsWithoutKnowledge, forKey: .rejectQuestionsWithoutKnowledge)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case persona
        case additionalPromptText
        case categoryGenerationPromptText
        case contentSafetyViolationResponsePromptText
        case rejectQuestionsWithoutKnowledge
    }
}