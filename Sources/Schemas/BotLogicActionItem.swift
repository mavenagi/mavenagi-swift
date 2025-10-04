import Foundation

public struct BotLogicActionItem: Codable, Hashable, Sendable {
    public let actionsReviewed: [BotLogicActionReviewedDetail]
    public let actionsExecuted: [BotLogicActionExecutedDetail]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        actionsReviewed: [BotLogicActionReviewedDetail],
        actionsExecuted: [BotLogicActionExecutedDetail],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.actionsReviewed = actionsReviewed
        self.actionsExecuted = actionsExecuted
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.actionsReviewed = try container.decode([BotLogicActionReviewedDetail].self, forKey: .actionsReviewed)
        self.actionsExecuted = try container.decode([BotLogicActionExecutedDetail].self, forKey: .actionsExecuted)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.actionsReviewed, forKey: .actionsReviewed)
        try container.encode(self.actionsExecuted, forKey: .actionsExecuted)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case actionsReviewed
        case actionsExecuted
    }
}