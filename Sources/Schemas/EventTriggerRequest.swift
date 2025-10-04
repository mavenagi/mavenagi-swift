import Foundation

public struct EventTriggerRequest: Codable, Hashable, Sendable {
    /// The description of what the event trigger does, shown in the Maven Dashboard
    public let description: String
    /// The type of event trigger this app wishes to handle.
    /// 
    /// Conversation triggers fire when a conversation is created, after each additional message, and upon deletion events.
    /// There is a small delay before trigger execution to allow time for conversation analysis to complete.
    /// 
    /// Feedback can not be modified, so the feedback trigger fires immediately after feedback is created.
    public let type: EventTriggerType
    /// ID that uniquely identifies this event trigger
    public let triggerId: EntityIdBase
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        description: String,
        type: EventTriggerType,
        triggerId: EntityIdBase,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.description = description
        self.type = type
        self.triggerId = triggerId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try container.decode(String.self, forKey: .description)
        self.type = try container.decode(EventTriggerType.self, forKey: .type)
        self.triggerId = try container.decode(EntityIdBase.self, forKey: .triggerId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.triggerId, forKey: .triggerId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case description
        case type
        case triggerId
    }
}