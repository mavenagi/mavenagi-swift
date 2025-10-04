import Foundation

/// The organizationId and agentId are inferred from the context.
public struct EntityIdWithoutAgent: Codable, Hashable, Sendable {
    /// Externally supplied ID to uniquely identify this object. Is globally unique when combined with all other entityId fields (type, appId, organizationId, agentId)
    public let referenceId: String
    /// The object type
    public let type: EntityType
    /// The ID of the application that created this object
    public let appId: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        referenceId: String,
        type: EntityType,
        appId: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.referenceId = referenceId
        self.type = type
        self.appId = appId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.referenceId = try container.decode(String.self, forKey: .referenceId)
        self.type = try container.decode(EntityType.self, forKey: .type)
        self.appId = try container.decode(String.self, forKey: .appId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.referenceId, forKey: .referenceId)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.appId, forKey: .appId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case referenceId
        case type
        case appId
    }
}