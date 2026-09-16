import Foundation

public struct SimulationContext: Codable, Hashable, Sendable {
    /// Deprecated. Superseded by charters, which determine agent behavior per turn. Has no effect for agents using charters.
    /// 
    /// If provided, overrides the agent's default additional prompt text during the simulation.
    public let additionalPromptText: String?
    /// Deprecated. Superseded by charters, which determine agent behavior per turn. Has no effect for agents using charters.
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