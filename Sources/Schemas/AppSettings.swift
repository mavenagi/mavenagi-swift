import Foundation

public struct AppSettings: Codable, Hashable, Sendable {
    /// The ID of an organization.
    public let organizationId: String
    /// The ID of an agent.
    public let agentId: String
    /// The settings that were set during installation.
    public let settings: [String: JSONValue]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        organizationId: String,
        agentId: String,
        settings: [String: JSONValue],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.organizationId = organizationId
        self.agentId = agentId
        self.settings = settings
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.organizationId = try container.decode(String.self, forKey: .organizationId)
        self.agentId = try container.decode(String.self, forKey: .agentId)
        self.settings = try container.decode([String: JSONValue].self, forKey: .settings)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.organizationId, forKey: .organizationId)
        try container.encode(self.agentId, forKey: .agentId)
        try container.encode(self.settings, forKey: .settings)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case organizationId
        case agentId
        case settings
    }
}