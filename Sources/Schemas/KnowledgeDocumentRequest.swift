import Foundation

public struct KnowledgeDocumentRequest: Codable, Hashable, Sendable {
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
    public let knowledgeDocumentId: EntityIdBase
    /// ID that uniquely identifies which knowledge base version to create the document in. If not provided will use the most recent version of the knowledge base.
    public let versionId: EntityIdWithoutAgent?
    public let contentType: KnowledgeDocumentContentType
    /// The content of the document. Not shown directly to users. May be provided in HTML or markdown. HTML will be converted to markdown automatically. Images are not currently supported and will be ignored.
    public let content: String
    /// Metadata for the knowledge document.
    public let metadata: [String: String]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        title: String,
        url: String? = nil,
        language: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        author: String? = nil,
        knowledgeDocumentId: EntityIdBase,
        versionId: EntityIdWithoutAgent? = nil,
        contentType: KnowledgeDocumentContentType,
        content: String,
        metadata: [String: String]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.title = title
        self.url = url
        self.language = language
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.author = author
        self.knowledgeDocumentId = knowledgeDocumentId
        self.versionId = versionId
        self.contentType = contentType
        self.content = content
        self.metadata = metadata
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
        self.knowledgeDocumentId = try container.decode(EntityIdBase.self, forKey: .knowledgeDocumentId)
        self.versionId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .versionId)
        self.contentType = try container.decode(KnowledgeDocumentContentType.self, forKey: .contentType)
        self.content = try container.decode(String.self, forKey: .content)
        self.metadata = try container.decodeIfPresent([String: String].self, forKey: .metadata)
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
        try container.encodeIfPresent(self.versionId, forKey: .versionId)
        try container.encode(self.contentType, forKey: .contentType)
        try container.encode(self.content, forKey: .content)
        try container.encodeIfPresent(self.metadata, forKey: .metadata)
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
        case versionId
        case contentType
        case content
        case metadata
    }
}