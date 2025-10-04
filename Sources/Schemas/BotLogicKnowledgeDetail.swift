import Foundation

public struct BotLogicKnowledgeDetail: Codable, Hashable, Sendable {
    public let knowledgeBaseId: EntityIdWithoutAgent
    public let documentId: EntityIdWithoutAgent
    public let documentName: String
    public let documentExcerpt: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        knowledgeBaseId: EntityIdWithoutAgent,
        documentId: EntityIdWithoutAgent,
        documentName: String,
        documentExcerpt: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.knowledgeBaseId = knowledgeBaseId
        self.documentId = documentId
        self.documentName = documentName
        self.documentExcerpt = documentExcerpt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.knowledgeBaseId = try container.decode(EntityIdWithoutAgent.self, forKey: .knowledgeBaseId)
        self.documentId = try container.decode(EntityIdWithoutAgent.self, forKey: .documentId)
        self.documentName = try container.decode(String.self, forKey: .documentName)
        self.documentExcerpt = try container.decode(String.self, forKey: .documentExcerpt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.knowledgeBaseId, forKey: .knowledgeBaseId)
        try container.encode(self.documentId, forKey: .documentId)
        try container.encode(self.documentName, forKey: .documentName)
        try container.encode(self.documentExcerpt, forKey: .documentExcerpt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case knowledgeBaseId
        case documentId
        case documentName
        case documentExcerpt
    }
}