import Foundation

public struct KnowledgeDocumentResponse: Codable, Hashable, Sendable {
    /// ID that uniquely identifies this knowledge document within its knowledge base
    public let knowledgeDocumentId: EntityId
    /// ID that uniquely identifies the knowledge base version that contains this document.
    /// This may be missing on legacy documents.
    public let knowledgeBaseVersionId: EntityId?
    /// The title of the document. Will be shown as part of answers. May be missing on legacy documents.
    public let title: String?
    /// Whether the document is included in the agent's knowledge.
    public let llmInclusionStatus: LlmInclusionStatus
    /// The time at which this document was created.
    public let createdAt: Date
    /// The time at which this document was last modified.
    public let updatedAt: Date
    /// The URL of the document. Should be visible to end users. Will be shown as part of answers. Not used for crawling.
    public let url: String?
    /// The document language. Must be a valid ISO 639-1 language code.
    public let language: String?
    /// The name of the author who created this document.
    public let author: String?
    /// The current processing status of the knowledge document
    public let processingStatus: KnowledgeDocumentStatus?
    /// The content of the document in markdown format. Not shown directly to users.
    public let content: String
    /// If the document is associated with an asset, this will contain the asset metadata
    public let asset: AttachmentResponse?
    /// Metadata for the knowledge document.
    public let metadata: [String: String]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        knowledgeDocumentId: EntityId,
        knowledgeBaseVersionId: EntityId? = nil,
        title: String? = nil,
        llmInclusionStatus: LlmInclusionStatus,
        createdAt: Date,
        updatedAt: Date,
        url: String? = nil,
        language: String? = nil,
        author: String? = nil,
        processingStatus: KnowledgeDocumentStatus? = nil,
        content: String,
        asset: AttachmentResponse? = nil,
        metadata: [String: String],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.knowledgeDocumentId = knowledgeDocumentId
        self.knowledgeBaseVersionId = knowledgeBaseVersionId
        self.title = title
        self.llmInclusionStatus = llmInclusionStatus
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.url = url
        self.language = language
        self.author = author
        self.processingStatus = processingStatus
        self.content = content
        self.asset = asset
        self.metadata = metadata
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.knowledgeDocumentId = try container.decode(EntityId.self, forKey: .knowledgeDocumentId)
        self.knowledgeBaseVersionId = try container.decodeIfPresent(EntityId.self, forKey: .knowledgeBaseVersionId)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.llmInclusionStatus = try container.decode(LlmInclusionStatus.self, forKey: .llmInclusionStatus)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.processingStatus = try container.decodeIfPresent(KnowledgeDocumentStatus.self, forKey: .processingStatus)
        self.content = try container.decode(String.self, forKey: .content)
        self.asset = try container.decodeIfPresent(AttachmentResponse.self, forKey: .asset)
        self.metadata = try container.decode([String: String].self, forKey: .metadata)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.knowledgeDocumentId, forKey: .knowledgeDocumentId)
        try container.encodeIfPresent(self.knowledgeBaseVersionId, forKey: .knowledgeBaseVersionId)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encode(self.llmInclusionStatus, forKey: .llmInclusionStatus)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.language, forKey: .language)
        try container.encodeIfPresent(self.author, forKey: .author)
        try container.encodeIfPresent(self.processingStatus, forKey: .processingStatus)
        try container.encode(self.content, forKey: .content)
        try container.encodeIfPresent(self.asset, forKey: .asset)
        try container.encode(self.metadata, forKey: .metadata)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case knowledgeDocumentId
        case knowledgeBaseVersionId
        case title
        case llmInclusionStatus
        case createdAt
        case updatedAt
        case url
        case language
        case author
        case processingStatus
        case content
        case asset
        case metadata
    }
}