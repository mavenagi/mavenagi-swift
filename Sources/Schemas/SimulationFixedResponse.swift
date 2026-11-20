import Foundation

public struct SimulationFixedResponse: Codable, Hashable, Sendable {
    /// The action's result. This is what the agent is given, whether it succeeded or failed.
    public let response: String
    /// Structured data returned alongside the response. Must serialize to fewer than 10,000 characters of JSON; data over that limit is omitted and the response is kept.
    public let data: [String: JSONValue]?
    /// Whether the action succeeded. Defaults to SUCCESS when absent.
    public let status: ActionExecutionStatus?
    /// Why the action failed, when status is ERROR. Never given to the agent. Truncated to 2,000 characters; a blank value is treated as if it were absent.
    public let errorMessage: String?
    /// State the action would have changed. The platform writes it each time this mock answers,
    /// under the app that initialized the conversation; the mocked app is not called. Both
    /// writes are attempted; if either fails, the action's result is an error and the other
    /// write stays applied. `userData` patches the initializing app's profile of the user who
    /// sent the message that triggered the action: that user must be a `SIMULATION` user with a
    /// profile under that app. Allowed on an `actionMocks` entry, not on
    /// `defaultActionBehavior`, and not with an `ERROR` status: a failed action changes no
    /// state.
    public let effects: ActionEffects?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        response: String,
        data: [String: JSONValue]? = nil,
        status: ActionExecutionStatus? = nil,
        errorMessage: String? = nil,
        effects: ActionEffects? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.response = response
        self.data = data
        self.status = status
        self.errorMessage = errorMessage
        self.effects = effects
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.response = try container.decode(String.self, forKey: .response)
        self.data = try container.decodeIfPresent([String: JSONValue].self, forKey: .data)
        self.status = try container.decodeIfPresent(ActionExecutionStatus.self, forKey: .status)
        self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
        self.effects = try container.decodeIfPresent(ActionEffects.self, forKey: .effects)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.response, forKey: .response)
        try container.encodeIfPresent(self.data, forKey: .data)
        try container.encodeIfPresent(self.status, forKey: .status)
        try container.encodeIfPresent(self.errorMessage, forKey: .errorMessage)
        try container.encodeIfPresent(self.effects, forKey: .effects)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case response
        case data
        case status
        case errorMessage
        case effects
    }
}