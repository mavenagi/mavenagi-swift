import Foundation

public struct CreateAgentRequest: Codable, Hashable, Sendable {
    /// The name of the agent.
    public let name: String
    /// The environment of the agent.
    public let environment: AgentEnvironment
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        environment: AgentEnvironment,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.environment = environment
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.environment = try container.decode(AgentEnvironment.self, forKey: .environment)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.environment, forKey: .environment)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case environment
    }
}