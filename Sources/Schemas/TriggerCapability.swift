import Foundation

public struct TriggerCapability: Codable, Hashable, Sendable {
    public let name: String
    public let description: Nullable<String>
    /// Timestamp when the capability was created
    public let createdAt: Date
    /// Whether this capability will be called by Maven.
    public let enabled: Bool
    public let version: Int
    /// ID that uniquely identifies this capability
    public let capabilityId: EntityId
    public let triggerType: TriggerType
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        description: Nullable<String>,
        createdAt: Date,
        enabled: Bool,
        version: Int,
        capabilityId: EntityId,
        triggerType: TriggerType,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.description = description
        self.createdAt = createdAt
        self.enabled = enabled
        self.version = version
        self.capabilityId = capabilityId
        self.triggerType = triggerType
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(Nullable<String>.self, forKey: .description)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.version = try container.decode(Int.self, forKey: .version)
        self.capabilityId = try container.decode(EntityId.self, forKey: .capabilityId)
        self.triggerType = try container.decode(TriggerType.self, forKey: .triggerType)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.enabled, forKey: .enabled)
        try container.encode(self.version, forKey: .version)
        try container.encode(self.capabilityId, forKey: .capabilityId)
        try container.encode(self.triggerType, forKey: .triggerType)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case description
        case createdAt
        case enabled
        case version
        case capabilityId
        case triggerType
    }
}