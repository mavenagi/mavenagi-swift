import Foundation

public struct EventTriggerRequest: Codable, Hashable, Sendable {
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
    /// The name of the trigger, displayed to end users. If not set, a name is derived from the app ID and trigger type.
    public let name: String?
    /// The description of what the event trigger does, shown in the Maven Dashboard
    public let description: String
    /// ID that uniquely identifies this event trigger
    public let triggerId: EntityIdBase
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: EventTriggerType,
        condition: EventCondition? = nil,
        name: String? = nil,
        description: String,
        triggerId: EntityIdBase,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.condition = condition
        self.name = name
        self.description = description
        self.triggerId = triggerId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(EventTriggerType.self, forKey: .type)
        self.condition = try container.decodeIfPresent(EventCondition.self, forKey: .condition)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.triggerId = try container.decode(EntityIdBase.self, forKey: .triggerId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.condition, forKey: .condition)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.triggerId, forKey: .triggerId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case condition
        case name
        case description
        case triggerId
    }
}