import Foundation

/// The ID of an object that belongs to an organization and to none of its agents. It has no `agentId`,
/// and none is inferred.
public struct OrganizationLevelEntityId: Codable, Hashable, Sendable {
    /// The object type
    public let type: EntityType
    /// The ID of the application that created this object
    public let appId: String
    /// Externally supplied ID to uniquely identify this object. Is globally unique when combined with the other fields of its ID.
    /// 
    /// Must be less than 192 characters and contain only:
    /// - alphanumeric characters (`a-z`, `A-Z`, `0-9`)
    /// - hyphens (`-`)
    /// - underscores (`_`)
    /// - plus signs (`+`)
    /// - periods (`.`)
    /// - at symbol (`@`)
    /// - pipe symbol (`|`)
    public let referenceId: String
    /// The ID of the organization that this object belongs to
    public let organizationId: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: EntityType,
        appId: String,
        referenceId: String,
        organizationId: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.appId = appId
        self.referenceId = referenceId
        self.organizationId = organizationId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(EntityType.self, forKey: .type)
        self.appId = try container.decode(String.self, forKey: .appId)
        self.referenceId = try container.decode(String.self, forKey: .referenceId)
        self.organizationId = try container.decode(String.self, forKey: .organizationId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.appId, forKey: .appId)
        try container.encode(self.referenceId, forKey: .referenceId)
        try container.encode(self.organizationId, forKey: .organizationId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case appId
        case referenceId
        case organizationId
    }
}