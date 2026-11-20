import Foundation

/// How a simulation evaluates charters and handles the actions the agent executes.
public struct SimulationSetupFields: Codable, Hashable, Sendable {
    /// When true, the simulation evaluates the agent's charters even if charter evaluation is
    /// turned off for the agent. When absent or false, the simulation follows the agent's own
    /// charter evaluation setting, like any other conversation. While charters are evaluated,
    /// `additionalPromptText` has no effect. Not yet enabled for every agent: until it is, the
    /// value is stored and returned, and the agent's own setting applies. A conversation that
    /// already exists keeps the value it was created with.
    public let evaluateWithCharters: Bool?
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
        evaluateWithCharters: Bool? = nil,
        actionMocks: [SimulationActionMock]? = nil,
        defaultActionBehavior: SimulationActionBehavior? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.evaluateWithCharters = evaluateWithCharters
        self.actionMocks = actionMocks
        self.defaultActionBehavior = defaultActionBehavior
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.evaluateWithCharters = try container.decodeIfPresent(Bool.self, forKey: .evaluateWithCharters)
        self.actionMocks = try container.decodeIfPresent([SimulationActionMock].self, forKey: .actionMocks)
        self.defaultActionBehavior = try container.decodeIfPresent(SimulationActionBehavior.self, forKey: .defaultActionBehavior)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.evaluateWithCharters, forKey: .evaluateWithCharters)
        try container.encodeIfPresent(self.actionMocks, forKey: .actionMocks)
        try container.encodeIfPresent(self.defaultActionBehavior, forKey: .defaultActionBehavior)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case evaluateWithCharters
        case actionMocks
        case defaultActionBehavior
    }
}