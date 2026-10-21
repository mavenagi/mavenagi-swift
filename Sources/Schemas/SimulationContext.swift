import Foundation

/// Conversations with a simulation context are the runs on the Agent Designer "Simulator" page.
public struct SimulationContext: Codable, Hashable, Sendable {
    /// Deprecated. Superseded by charters, which determine agent behavior per round. Has no effect for agents using charters.
    /// 
    /// If provided, overrides the agent's default additional prompt text during the simulation.
    /// 
    /// Shown in Agent Designer as "Additional persona instructions".
    public let additionalPromptText: String?
    /// Deprecated. Superseded by charters, which determine agent behavior per round. Has no effect for agents using charters.
    public let persona: LlmPersona?
    /// If provided, knowledge search will be restricted to the provided list of knowledge bases. Otherwise, all active knowledge bases will be used. An empty list means no knowledge bases will be used.
    public let availableKnowledgeBases: JSONValue?
    /// The agent variant to run the simulation on, instead of the one the agent's traffic rules
    /// would choose. Any ACTIVE variant of the agent with no staged edits can be named, including
    /// one with no traffic. The conversation is pinned to it when created, like any other
    /// conversation; the conversation's `variantId` reports it, and this field is not returned.
    /// 
    /// Rejected with reason `VARIANT_NOT_ACTIVE` for an archived or deleted variant, and
    /// `VARIANT_HAS_STAGED_EDITS` for one with staged edits (publish them first). Rejected too
    /// while agent variants aren't enabled for the agent. A conversation that already exists
    /// keeps the variant it was created with.
    public let variantId: EntityIdWithoutAgent?
    /// What the platform does when the agent executes each action during this simulation. At
    /// most one entry per action; a request that names an action twice is rejected. An action
    /// with no entry follows `defaultActionBehavior`. A conversation that already exists keeps
    /// the mocks and default it was created with.
    public let actionMocks: [SimulationActionMock]?
    /// What the platform does when the agent executes an action that has no `actionMocks`
    /// entry. When absent, the action's app is called as usual. A `fixedResponse` here keeps the
    /// simulation from calling any action's app that `actionMocks` doesn't name with `callApp`;
    /// its templates are rendered over the parameters of whichever action was called.
    public let defaultActionBehavior: SimulationActionBehavior?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        additionalPromptText: String? = nil,
        persona: LlmPersona? = nil,
        availableKnowledgeBases: JSONValue? = nil,
        variantId: EntityIdWithoutAgent? = nil,
        actionMocks: [SimulationActionMock]? = nil,
        defaultActionBehavior: SimulationActionBehavior? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.additionalPromptText = additionalPromptText
        self.persona = persona
        self.availableKnowledgeBases = availableKnowledgeBases
        self.variantId = variantId
        self.actionMocks = actionMocks
        self.defaultActionBehavior = defaultActionBehavior
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.additionalPromptText = try container.decodeIfPresent(String.self, forKey: .additionalPromptText)
        self.persona = try container.decodeIfPresent(LlmPersona.self, forKey: .persona)
        self.availableKnowledgeBases = try container.decodeIfPresent(JSONValue.self, forKey: .availableKnowledgeBases)
        self.variantId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .variantId)
        self.actionMocks = try container.decodeIfPresent([SimulationActionMock].self, forKey: .actionMocks)
        self.defaultActionBehavior = try container.decodeIfPresent(SimulationActionBehavior.self, forKey: .defaultActionBehavior)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.additionalPromptText, forKey: .additionalPromptText)
        try container.encodeIfPresent(self.persona, forKey: .persona)
        try container.encodeIfPresent(self.availableKnowledgeBases, forKey: .availableKnowledgeBases)
        try container.encodeIfPresent(self.variantId, forKey: .variantId)
        try container.encodeIfPresent(self.actionMocks, forKey: .actionMocks)
        try container.encodeIfPresent(self.defaultActionBehavior, forKey: .defaultActionBehavior)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case additionalPromptText
        case persona
        case availableKnowledgeBases
        case variantId
        case actionMocks
        case defaultActionBehavior
    }
}