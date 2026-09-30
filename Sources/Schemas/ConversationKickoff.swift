import Foundation

/// A Conversation Kickoff installed on an agent: code that runs when a conversation is created,
/// before the agent produces its first reply.
/// 
/// A kickoff has no settings of its own beyond the fields every capability has.
public struct ConversationKickoff: Codable, Hashable, Sendable {
    /// The capability's display name, shown to whoever manages the agent. A trigger registered
    /// without one is named after the app that registered it and the event it fires on.
    public let name: String
    /// What the capability does. Shown to whoever manages the agent, and for the types the LLM
    /// can choose between, used to decide when the capability applies.
    public let description: String?
    /// When the capability was created.
    public let createdAt: Date
    /// When the capability was last modified.
    public let updatedAt: Date
    /// Whether the agent uses this capability, and whether it still exists.
    public let status: CapabilityStatus
    /// ID that uniquely identifies this Conversation Kickoff.
    public let kickoffId: EntityId
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        description: String? = nil,
        createdAt: Date,
        updatedAt: Date,
        status: CapabilityStatus,
        kickoffId: EntityId,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.description = description
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.status = status
        self.kickoffId = kickoffId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.status = try container.decode(CapabilityStatus.self, forKey: .status)
        self.kickoffId = try container.decode(EntityId.self, forKey: .kickoffId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.updatedAt, forKey: .updatedAt)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.kickoffId, forKey: .kickoffId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case description
        case createdAt
        case updatedAt
        case status
        case kickoffId
    }
}