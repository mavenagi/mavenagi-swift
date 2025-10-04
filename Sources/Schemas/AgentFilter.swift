import Foundation

public struct AgentFilter: Codable, Hashable, Sendable {
    /// The environment of the agent.
    public let environment: AgentEnvironment?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        environment: AgentEnvironment? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.environment = environment
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.environment = try container.decodeIfPresent(AgentEnvironment.self, forKey: .environment)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.environment, forKey: .environment)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case environment
    }
}