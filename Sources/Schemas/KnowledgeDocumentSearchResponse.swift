import Foundation

public struct KnowledgeDocumentSearchResponse: Codable, Hashable, Sendable {
    /// The title of the document. Will be shown as part of answers.
    public let title: String
    /// The URL of the document. Should be visible to end users. Will be shown as part of answers. Not used for crawling.
    public let url: String?
    /// The document language. Must be a valid ISO 639-1 language code.
    public let language: String?
    /// The time at which this document was created.
    public let createdAt: Date?
    /// The time at which this document was last modified.
    public let updatedAt: Date?
    /// The name of the author who created this document.
    public let author: String?
    /// ID that uniquely identifies this knowledge document within its knowledge base
    public let knowledgeDocumentId: EntityId
    /// ID that uniquely identifies the knowledge base version that contains this document.
    /// This may be missing on legacy documents.
    public let knowledgeBaseVersionId: EntityId?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        title: String,
        url: String? = nil,
        language: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        author: String? = nil,
        knowledgeDocumentId: EntityId,
        knowledgeBaseVersionId: EntityId? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.title = title
        self.url = url
        self.language = language
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.author = author
        self.knowledgeDocumentId = knowledgeDocumentId
        self.knowledgeBaseVersionId = knowledgeBaseVersionId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.knowledgeDocumentId = try container.decode(EntityId.self, forKey: .knowledgeDocumentId)
        self.knowledgeBaseVersionId = try container.decodeIfPresent(EntityId.self, forKey: .knowledgeBaseVersionId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.title, forKey: .title)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.language, forKey: .language)
        try container.encodeIfPresent(self.createdAt, forKey: .createdAt)
        try container.encodeIfPresent(self.updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(self.author, forKey: .author)
        try container.encode(self.knowledgeDocumentId, forKey: .knowledgeDocumentId)
        try container.encodeIfPresent(self.knowledgeBaseVersionId, forKey: .knowledgeBaseVersionId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case title
        case url
        case language
        case createdAt
        case updatedAt
        case author
        case knowledgeDocumentId
        case knowledgeBaseVersionId
    }
}