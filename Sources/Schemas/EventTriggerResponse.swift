import Foundation

public struct EventTriggerResponse: Codable, Hashable, Sendable {
    /// The type of event trigger this app wishes to handle.
    /// 
    /// Conversation triggers fire when a conversation is created, after each additional message, and upon deletion events.
    /// There is a small delay before trigger execution to allow time for conversation analysis to complete.
    /// 
    /// Events are immutable, so an event trigger fires immediately after the event is created.
    /// 
    /// Inbox triggers fire when an inbox item is created or updated.
    public let type: EventTriggerType
    /// Narrows which events fire this trigger. Without one the trigger fires for every event on
    /// the agent. Re-registering writes whatever condition the request carries, so omitting it
    /// removes one; PATCH changes or removes a condition without re-registering.
    /// 
    /// Only allowed on `EVENT_CREATED`; the other trigger types reject it.
    public let condition: EventCondition?
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
    /// ID that uniquely identifies this event trigger
    public let triggerId: EntityId
    /// Deprecated. Superseded by `status`, which says the same thing for every capability type.
    /// 
    /// Whether this trigger will be called by Maven.
    public let enabled: Bool
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: EventTriggerType,
        condition: EventCondition? = nil,
        name: String,
        description: String? = nil,
        createdAt: Date,
        updatedAt: Date,
        status: CapabilityStatus,
        triggerId: EntityId,
        enabled: Bool,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.condition = condition
        self.name = name
        self.description = description
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.status = status
        self.triggerId = triggerId
        self.enabled = enabled
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(EventTriggerType.self, forKey: .type)
        self.condition = try container.decodeIfPresent(EventCondition.self, forKey: .condition)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.status = try container.decode(CapabilityStatus.self, forKey: .status)
        self.triggerId = try container.decode(EntityId.self, forKey: .triggerId)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.condition, forKey: .condition)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.updatedAt, forKey: .updatedAt)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.triggerId, forKey: .triggerId)
        try container.encode(self.enabled, forKey: .enabled)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case condition
        case name
        case description
        case createdAt
        case updatedAt
        case status
        case triggerId
        case enabled
    }
}