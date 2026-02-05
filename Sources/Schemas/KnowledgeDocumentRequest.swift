import Foundation

public struct KnowledgeDocumentRequest: Codable, Hashable, Sendable {
    /// The URL of the document. Should be visible to end users. Will be shown as part of answers. Not used for crawling.
    public let url: String?
    /// The document language. Must be a valid ISO 639-1 language code.
    public let language: String?
    /// The name of the author who created this document.
    public let author: String?
    /// ID that uniquely identifies this knowledge document within its knowledge base
    public let knowledgeDocumentId: EntityIdBase
    /// ID that uniquely identifies which knowledge base version to create the document in. If not provided will use the most recent version of the knowledge base.
    public let versionId: EntityIdWithoutAgent?
    /// Type of knowledge document content, if content is provided. This does not need to be set if content is not provided
    public let contentType: KnowledgeDocumentContentType
    /// The title of the document. Will be shown as part of answers.
    public let title: String
    /// (Currently in BETA. Use at your own risk, and may not work in some circumstances) ID of the asset associated with this document. This asset will be transformed into text and set as the content of the document. The following types are supported: `application/pdf`, `text/plain`.  Either this or content is required, but not both.
    public let assetId: EntityIdWithoutAgent?
    /// The content of the document. Not shown directly to users. May be provided in HTML or markdown. HTML will be converted to markdown automatically. Images are not currently supported and will be ignored. Either this or assetId is required, but not both
    public let content: String?
    /// Metadata for the knowledge document.
    public let metadata: [String: String]?
    /// The time at which this document was created.
    public let createdAt: Date?
    /// The time at which this document was last modified.
    public let updatedAt: Date?
    /// Scoped entities this document is associated with for context-based filtering. By default, the document is associated with the agent.
    public let relevantEntities: JSONValue?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        url: String? = nil,
        language: String? = nil,
        author: String? = nil,
        knowledgeDocumentId: EntityIdBase,
        versionId: EntityIdWithoutAgent? = nil,
        contentType: KnowledgeDocumentContentType,
        title: String,
        assetId: EntityIdWithoutAgent? = nil,
        content: String? = nil,
        metadata: [String: String]? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        relevantEntities: JSONValue? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.url = url
        self.language = language
        self.author = author
        self.knowledgeDocumentId = knowledgeDocumentId
        self.versionId = versionId
        self.contentType = contentType
        self.title = title
        self.assetId = assetId
        self.content = content
        self.metadata = metadata
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.relevantEntities = relevantEntities
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.knowledgeDocumentId = try container.decode(EntityIdBase.self, forKey: .knowledgeDocumentId)
        self.versionId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .versionId)
        self.contentType = try container.decode(KnowledgeDocumentContentType.self, forKey: .contentType)
        self.title = try container.decode(String.self, forKey: .title)
        self.assetId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .assetId)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.metadata = try container.decodeIfPresent([String: String].self, forKey: .metadata)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.relevantEntities = try container.decodeIfPresent(JSONValue.self, forKey: .relevantEntities)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.language, forKey: .language)
        try container.encodeIfPresent(self.author, forKey: .author)
        try container.encode(self.knowledgeDocumentId, forKey: .knowledgeDocumentId)
        try container.encodeIfPresent(self.versionId, forKey: .versionId)
        try container.encode(self.contentType, forKey: .contentType)
        try container.encode(self.title, forKey: .title)
        try container.encodeIfPresent(self.assetId, forKey: .assetId)
        try container.encodeIfPresent(self.content, forKey: .content)
        try container.encodeIfPresent(self.metadata, forKey: .metadata)
        try container.encodeIfPresent(self.createdAt, forKey: .createdAt)
        try container.encodeIfPresent(self.updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(self.relevantEntities, forKey: .relevantEntities)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case url
        case language
        case author
        case knowledgeDocumentId
        case versionId
        case contentType
        case title
        case assetId
        case content
        case metadata
        case createdAt
        case updatedAt
        case relevantEntities
    }
}