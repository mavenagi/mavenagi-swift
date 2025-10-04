import Foundation

public struct DocumentInformation: Codable, Hashable, Sendable {
    /// Unique identifier for the knowledge base.
    public let knowledgeBaseId: EntityIdWithoutAgent
    /// Unique identifier for the document.
    public let documentId: EntityIdWithoutAgent
    /// Title of the document.
    public let title: String?
    /// Snippet or summary of the document.
    public let snippet: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        knowledgeBaseId: EntityIdWithoutAgent,
        documentId: EntityIdWithoutAgent,
        title: String? = nil,
        snippet: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.knowledgeBaseId = knowledgeBaseId
        self.documentId = documentId
        self.title = title
        self.snippet = snippet
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.knowledgeBaseId = try container.decode(EntityIdWithoutAgent.self, forKey: .knowledgeBaseId)
        self.documentId = try container.decode(EntityIdWithoutAgent.self, forKey: .documentId)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.snippet = try container.decodeIfPresent(String.self, forKey: .snippet)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.knowledgeBaseId, forKey: .knowledgeBaseId)
        try container.encode(self.documentId, forKey: .documentId)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.snippet, forKey: .snippet)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case knowledgeBaseId
        case documentId
        case title
        case snippet
    }
}