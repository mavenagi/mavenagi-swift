import Foundation

public struct SimulationContext: Codable, Hashable, Sendable {
    /// If provided, overrides the agent's default additional prompt text during the simulation. 
    /// Note that this field is provided for backwards compatibility and will be removed in a future release. 
    /// Instead please use the `availableKnowledgeBases` field to include a knowledge base with a document `llmInclusionStatus` set to `ALWAYS`.
    public let additionalPromptText: String?
    /// The persona to use during the simulation. If not provided, the agent's default persona will be used.
    public let persona: LlmPersona?
    /// If provided, knowledge search will be restricted to the provided list of knowledge bases. Otherwise, all active knowledge bases will be used. An empty list means no knowledge bases will be used.
    public let availableKnowledgeBases: JSONValue?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        additionalPromptText: String? = nil,
        persona: LlmPersona? = nil,
        availableKnowledgeBases: JSONValue? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.additionalPromptText = additionalPromptText
        self.persona = persona
        self.availableKnowledgeBases = availableKnowledgeBases
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.additionalPromptText = try container.decodeIfPresent(String.self, forKey: .additionalPromptText)
        self.persona = try container.decodeIfPresent(LlmPersona.self, forKey: .persona)
        self.availableKnowledgeBases = try container.decodeIfPresent(JSONValue.self, forKey: .availableKnowledgeBases)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.additionalPromptText, forKey: .additionalPromptText)
        try container.encodeIfPresent(self.persona, forKey: .persona)
        try container.encodeIfPresent(self.availableKnowledgeBases, forKey: .availableKnowledgeBases)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case additionalPromptText
        case persona
        case availableKnowledgeBases
    }
}