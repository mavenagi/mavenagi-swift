import Foundation

public struct KnowledgeDocumentSearchResponse: Codable, Hashable, Sendable {
    /// The URL of the document. Should be visible to end users. Will be shown as part of answers. Not used for crawling.
    public let url: String?
    /// The document language. Must be a valid ISO 639-1 language code.
    public let language: String?
    /// The name of the author who created this document.
    public let author: String?
    /// ID that uniquely identifies this knowledge document within its knowledge base
    public let knowledgeDocumentId: EntityId
    /// ID that uniquely identifies the knowledge base version that contains this document.
    /// This may be missing on legacy documents.
    public let knowledgeBaseVersionId: EntityId?
    /// ID that uniquely identifies the knowledge base that contains this document.
    public let knowledgeBaseId: EntityId
    /// The title of the document. Will be shown as part of answers. May be missing on legacy documents.
    public let title: String?
    /// Whether the document is included in the agent's knowledge.
    public let llmInclusionStatus: LlmInclusionStatus
    /// Whether the knowledge base is included in the agent's knowledge.
    public let knowledgeBaseLlmInclusionStatus: LlmInclusionStatus
    /// The time at which this document was created.
    public let createdAt: Date
    /// The time at which this document was last modified.
    public let updatedAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        url: String? = nil,
        language: String? = nil,
        author: String? = nil,
        knowledgeDocumentId: EntityId,
        knowledgeBaseVersionId: EntityId? = nil,
        knowledgeBaseId: EntityId,
        title: String? = nil,
        llmInclusionStatus: LlmInclusionStatus,
        knowledgeBaseLlmInclusionStatus: LlmInclusionStatus,
        createdAt: Date,
        updatedAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.url = url
        self.language = language
        self.author = author
        self.knowledgeDocumentId = knowledgeDocumentId
        self.knowledgeBaseVersionId = knowledgeBaseVersionId
        self.knowledgeBaseId = knowledgeBaseId
        self.title = title
        self.llmInclusionStatus = llmInclusionStatus
        self.knowledgeBaseLlmInclusionStatus = knowledgeBaseLlmInclusionStatus
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.knowledgeDocumentId = try container.decode(EntityId.self, forKey: .knowledgeDocumentId)
        self.knowledgeBaseVersionId = try container.decodeIfPresent(EntityId.self, forKey: .knowledgeBaseVersionId)
        self.knowledgeBaseId = try container.decode(EntityId.self, forKey: .knowledgeBaseId)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.llmInclusionStatus = try container.decode(LlmInclusionStatus.self, forKey: .llmInclusionStatus)
        self.knowledgeBaseLlmInclusionStatus = try container.decode(LlmInclusionStatus.self, forKey: .knowledgeBaseLlmInclusionStatus)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.language, forKey: .language)
        try container.encodeIfPresent(self.author, forKey: .author)
        try container.encode(self.knowledgeDocumentId, forKey: .knowledgeDocumentId)
        try container.encodeIfPresent(self.knowledgeBaseVersionId, forKey: .knowledgeBaseVersionId)
        try container.encode(self.knowledgeBaseId, forKey: .knowledgeBaseId)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encode(self.llmInclusionStatus, forKey: .llmInclusionStatus)
        try container.encode(self.knowledgeBaseLlmInclusionStatus, forKey: .knowledgeBaseLlmInclusionStatus)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.updatedAt, forKey: .updatedAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case url
        case language
        case author
        case knowledgeDocumentId
        case knowledgeBaseVersionId
        case knowledgeBaseId
        case title
        case llmInclusionStatus
        case knowledgeBaseLlmInclusionStatus
        case createdAt
        case updatedAt
    }
}