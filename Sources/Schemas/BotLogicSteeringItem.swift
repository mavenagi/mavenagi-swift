import Foundation

/// Present when this response was triggered by a steering ask (WELCOME or PROACTIVE) rather than a user message. The steering message itself is not returned in the conversation.
public struct BotLogicSteeringItem: Codable, Hashable, Sendable {
    /// The ask type that triggered this response.
    public let askType: AskType
    /// The steering text the agent was given, if any.
    public let text: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        askType: AskType,
        text: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.askType = askType
        self.text = text
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.askType = try container.decode(AskType.self, forKey: .askType)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.askType, forKey: .askType)
        try container.encodeIfPresent(self.text, forKey: .text)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case askType
        case text
    }
}