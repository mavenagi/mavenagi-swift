import Foundation

public struct AgentPrompting: Codable, Hashable, Sendable {
    /// The overall persona of the agent.
    public let persona: LlmPersona
    /// Additional text directly appended to the prompt. This field is replaced by Knowledge Documents with `llmInclusionsStatus` set to `ALWAYS`.
    public let additionalPromptText: String?
    /// LLM prompt for category generation. 
    /// 
    /// Use this to specify a fixed set of categories that an LLM should choose from when analyzing a conversation. 
    /// When not set uses a default prompt which gives the LLM flexibility to determine appropriate categories on its own.
    public let categoryGenerationPromptText: String?
    /// LLM prompt for generating a response when the user's question has been detected as unsafe. 
    /// 
    /// Use this to provide custom LLM generated replies when dealing with content safety violations.
    /// When not set, the system fallback message will be used and replies will not be personalized by the LLM as it will not be involved.
    public let contentSafetyViolationResponsePromptText: String?
    /// Return the system fallback message on all questions that have no relevant knowledge bases or actions.
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