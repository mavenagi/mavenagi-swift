import Foundation

extension Requests {
    public struct AgentPatchRequest: Codable, Hashable, Sendable {
        /// The name of the agent.
        public let name: String?
        /// The environment of the agent.
        public let environment: AgentEnvironment?
        /// The agent's default timezone. This is used when a timezone is not set on a conversation.
        public let defaultTimezone: String?
        /// The PII categories that are enabled for the agent.
        public let enabledPiiCategories: JSONValue?
        /// The system fallback message.
        /// 
        /// Rejected with reason `VARIANT_REQUIRED` while `SYSTEM_FALLBACK_MESSAGE` is in `getVersionedEntityTypes`; set it through `patchVersionedSettings`.
        public let systemFallbackMessage: Nullable<String>?
        /// Deprecated. Superseded by charters, which determine agent behavior per round. Has no effect for agents using charters.
        public let persona: LlmPersona?
        /// Deprecated. Superseded by charters, which determine agent behavior per round. Has no effect for agents using charters.
        public let additionalPromptText: Nullable<String>?
        /// Deprecated. Use `categoryIntelligentFieldId` instead. Not supported on new agents, and ignored while `categoryIntelligentFieldId` is set.
        /// 
        /// LLM prompt for category generation.
        public let categoryGenerationPromptText: Nullable<String>?
        /// The intelligent field whose value becomes each conversation's category. Send null to clear it.
        /// 
        /// Must be a `STRING` conversation field on this agent. Giving the field `enumOptions` is highly recommended, so the category comes from a fixed list.
        /// 
        /// The field must be `ACTIVE` to produce values. While it is inactive, conversations get no category. With agent variants, a conversation gets a category only if the field is active in its variant. Categories are capped at 280 characters.
        public let categoryIntelligentFieldId: Nullable<EntityIdWithoutAgent>?
        /// Instructions to an LLM that writes the reply when the user's message is blocked for harmful content (hate, self-harm, sexual or violence). The LLM sees only these instructions and the blocked message, not the agent's charters, knowledge or earlier messages. To send fixed wording, say so in the instructions, for example `Always reply with exactly: "…"`.
        /// 
        /// A message flagged as a prompt attack always gets the default reply, even when it was also flagged for harmful content. So does every blocked message while this is not set.
        /// 
        /// Rejected with reason `VARIANT_REQUIRED` while `CONTENT_SAFETY_VIOLATION_RESPONSE_PROMPT_TEXT` is in `getVersionedEntityTypes`; set it through `patchVersionedSettings`.
        public let contentSafetyViolationResponsePromptText: Nullable<String>?
        /// Deprecated. Superseded by charters, which determine agent behavior per round. Has no effect for agents using charters.
        /// 
        /// Return the system fallback message on all questions that have no relevant knowledge bases or actions.
        public let rejectQuestionsWithoutKnowledge: Bool?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            name: String? = nil,
            environment: AgentEnvironment? = nil,
            defaultTimezone: String? = nil,
            enabledPiiCategories: JSONValue? = nil,
            systemFallbackMessage: Nullable<String>? = nil,
            persona: LlmPersona? = nil,
            additionalPromptText: Nullable<String>? = nil,
            categoryGenerationPromptText: Nullable<String>? = nil,
            categoryIntelligentFieldId: Nullable<EntityIdWithoutAgent>? = nil,
            contentSafetyViolationResponsePromptText: Nullable<String>? = nil,
            rejectQuestionsWithoutKnowledge: Bool? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.name = name
            self.environment = environment
            self.defaultTimezone = defaultTimezone
            self.enabledPiiCategories = enabledPiiCategories
            self.systemFallbackMessage = systemFallbackMessage
            self.persona = persona
            self.additionalPromptText = additionalPromptText
            self.categoryGenerationPromptText = categoryGenerationPromptText
            self.categoryIntelligentFieldId = categoryIntelligentFieldId
            self.contentSafetyViolationResponsePromptText = contentSafetyViolationResponsePromptText
            self.rejectQuestionsWithoutKnowledge = rejectQuestionsWithoutKnowledge
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.environment = try container.decodeIfPresent(AgentEnvironment.self, forKey: .environment)
            self.defaultTimezone = try container.decodeIfPresent(String.self, forKey: .defaultTimezone)
            self.enabledPiiCategories = try container.decodeIfPresent(JSONValue.self, forKey: .enabledPiiCategories)
            self.systemFallbackMessage = try container.decodeNullableIfPresent(String.self, forKey: .systemFallbackMessage)
            self.persona = try container.decodeIfPresent(LlmPersona.self, forKey: .persona)
            self.additionalPromptText = try container.decodeNullableIfPresent(String.self, forKey: .additionalPromptText)
            self.categoryGenerationPromptText = try container.decodeNullableIfPresent(String.self, forKey: .categoryGenerationPromptText)
            self.categoryIntelligentFieldId = try container.decodeNullableIfPresent(EntityIdWithoutAgent.self, forKey: .categoryIntelligentFieldId)
            self.contentSafetyViolationResponsePromptText = try container.decodeNullableIfPresent(String.self, forKey: .contentSafetyViolationResponsePromptText)
            self.rejectQuestionsWithoutKnowledge = try container.decodeIfPresent(Bool.self, forKey: .rejectQuestionsWithoutKnowledge)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encodeIfPresent(self.name, forKey: .name)
            try container.encodeIfPresent(self.environment, forKey: .environment)
            try container.encodeIfPresent(self.defaultTimezone, forKey: .defaultTimezone)
            try container.encodeIfPresent(self.enabledPiiCategories, forKey: .enabledPiiCategories)
            try container.encodeNullableIfPresent(self.systemFallbackMessage, forKey: .systemFallbackMessage)
            try container.encodeIfPresent(self.persona, forKey: .persona)
            try container.encodeNullableIfPresent(self.additionalPromptText, forKey: .additionalPromptText)
            try container.encodeNullableIfPresent(self.categoryGenerationPromptText, forKey: .categoryGenerationPromptText)
            try container.encodeNullableIfPresent(self.categoryIntelligentFieldId, forKey: .categoryIntelligentFieldId)
            try container.encodeNullableIfPresent(self.contentSafetyViolationResponsePromptText, forKey: .contentSafetyViolationResponsePromptText)
            try container.encodeIfPresent(self.rejectQuestionsWithoutKnowledge, forKey: .rejectQuestionsWithoutKnowledge)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case name
            case environment
            case defaultTimezone
            case enabledPiiCategories
            case systemFallbackMessage
            case persona
            case additionalPromptText
            case categoryGenerationPromptText
            case categoryIntelligentFieldId
            case contentSafetyViolationResponsePromptText
            case rejectQuestionsWithoutKnowledge
        }
    }
}