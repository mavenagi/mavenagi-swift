import Foundation

/// Charter evaluation results for this bot response.
public struct BotLogicChartersItem: Codable, Hashable, Sendable {
    /// Charters that matched the conversation state and were used to generate this response.
    public let matchedCharters: [BotLogicCharterDetail]
    /// True when too many charters fit the initial criteria and evaluation was cut short. The matchedCharters list may be incomplete.
    public let evaluationTruncated: Bool
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        matchedCharters: [BotLogicCharterDetail],
        evaluationTruncated: Bool,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.matchedCharters = matchedCharters
        self.evaluationTruncated = evaluationTruncated
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.matchedCharters = try container.decode([BotLogicCharterDetail].self, forKey: .matchedCharters)
        self.evaluationTruncated = try container.decode(Bool.self, forKey: .evaluationTruncated)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.matchedCharters, forKey: .matchedCharters)
        try container.encode(self.evaluationTruncated, forKey: .evaluationTruncated)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case matchedCharters
        case evaluationTruncated
    }
}