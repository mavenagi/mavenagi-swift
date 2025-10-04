import Foundation

public struct AgentPatchRequest: Codable, Hashable, Sendable {
    /// The name of the agent.
    public let name: String?
    /// The environment of the agent.
    public let environment: AgentEnvironment?
    /// The agent's default timezone. This is used when a timezone is not set on a conversation.
    public let defaultTimezone: String?
    /// The PII categories that are enabled for the agent.
    public let enabledPiiCategories: JSONValue?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String? = nil,
        environment: AgentEnvironment? = nil,
        defaultTimezone: String? = nil,
        enabledPiiCategories: JSONValue? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.environment = environment
        self.defaultTimezone = defaultTimezone
        self.enabledPiiCategories = enabledPiiCategories
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.environment = try container.decodeIfPresent(AgentEnvironment.self, forKey: .environment)
        self.defaultTimezone = try container.decodeIfPresent(String.self, forKey: .defaultTimezone)
        self.enabledPiiCategories = try container.decodeIfPresent(JSONValue.self, forKey: .enabledPiiCategories)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.environment, forKey: .environment)
        try container.encodeIfPresent(self.defaultTimezone, forKey: .defaultTimezone)
        try container.encodeIfPresent(self.enabledPiiCategories, forKey: .enabledPiiCategories)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case environment
        case defaultTimezone
        case enabledPiiCategories
    }
}