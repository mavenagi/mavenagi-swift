import Foundation

public struct BotLogicActionReviewedDetail: Codable, Hashable, Sendable {
    public let actionId: EntityIdWithoutAgent
    public let actionName: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        actionId: EntityIdWithoutAgent,
        actionName: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.actionId = actionId
        self.actionName = actionName
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.actionId = try container.decode(EntityIdWithoutAgent.self, forKey: .actionId)
        self.actionName = try container.decode(String.self, forKey: .actionName)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.actionId, forKey: .actionId)
        try container.encode(self.actionName, forKey: .actionName)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case actionId
        case actionName
    }
}