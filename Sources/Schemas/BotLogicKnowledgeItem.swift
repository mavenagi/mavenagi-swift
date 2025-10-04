import Foundation

public struct BotLogicKnowledgeItem: Codable, Hashable, Sendable {
    public let knowledgeReviewed: [BotLogicKnowledgeDetail]
    public let knowledgeUtilized: [BotLogicKnowledgeDetail]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        knowledgeReviewed: [BotLogicKnowledgeDetail],
        knowledgeUtilized: [BotLogicKnowledgeDetail],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.knowledgeReviewed = knowledgeReviewed
        self.knowledgeUtilized = knowledgeUtilized
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.knowledgeReviewed = try container.decode([BotLogicKnowledgeDetail].self, forKey: .knowledgeReviewed)
        self.knowledgeUtilized = try container.decode([BotLogicKnowledgeDetail].self, forKey: .knowledgeUtilized)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.knowledgeReviewed, forKey: .knowledgeReviewed)
        try container.encode(self.knowledgeUtilized, forKey: .knowledgeUtilized)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case knowledgeReviewed
        case knowledgeUtilized
    }
}