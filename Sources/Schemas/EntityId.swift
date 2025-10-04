import Foundation

/// A fully specified object ID, unique across the entire system.
public struct EntityId: Codable, Hashable, Sendable {
    /// The object type
    public let type: EntityType
    /// The ID of the application that created this object
    public let appId: String
    /// Externally supplied ID to uniquely identify this object. Is globally unique when combined with all other entityId fields (type, appId, organizationId, agentId)
    public let referenceId: String
    /// The ID of the organization that this object belongs to
    public let organizationId: String
    /// The ID of the agent that this object belongs to
    public let agentId: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: EntityType,
        appId: String,
        referenceId: String,
        organizationId: String,
        agentId: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.appId = appId
        self.referenceId = referenceId
        self.organizationId = organizationId
        self.agentId = agentId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(EntityType.self, forKey: .type)
        self.appId = try container.decode(String.self, forKey: .appId)
        self.referenceId = try container.decode(String.self, forKey: .referenceId)
        self.organizationId = try container.decode(String.self, forKey: .organizationId)
        self.agentId = try container.decode(String.self, forKey: .agentId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.appId, forKey: .appId)
        try container.encode(self.referenceId, forKey: .referenceId)
        try container.encode(self.organizationId, forKey: .organizationId)
        try container.encode(self.agentId, forKey: .agentId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case appId
        case referenceId
        case organizationId
        case agentId
    }
}