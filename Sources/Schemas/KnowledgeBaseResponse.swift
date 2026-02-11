import Foundation

public struct KnowledgeBaseResponse: Codable, Hashable, Sendable {
    /// The name of the knowledge base
    public let name: String
    /// The preconditions that must be met for knowledge base be relevant to a conversation. Can be used to restrict knowledge bases to certain types of users.
    public let precondition: Precondition?
    /// The date and time when the knowledge base was created.
    public let createdAt: Date
    /// The date and time when the knowledge base was last updated.
    public let updatedAt: Date
    /// ID that uniquely identifies this knowledge base
    public let knowledgeBaseId: EntityId
    /// ID of the knowledge base version that is currently active. Documents can be fetched using this version ID.
    public let activeVersionId: EntityId?
    /// The status of the most recent version of the knowledge base.
    /// The `activeVersionId` will only be populated if this status is `SUCCEEDED`.
    /// Use the `listKnowledgeBaseVersions` endpoint to get the full list of versions.
    public let mostRecentVersionStatus: KnowledgeBaseVersionStatus
    /// The type of the knowledge base. Can not be changed once created.
    public let type: KnowledgeBaseType
    /// Metadata for the knowledge base.
    public let metadata: [String: String]
    /// The tags of the knowledge base.
    public let tags: JSONValue
    /// Determines whether documents in the knowledge base are sent to the LLM as part of a conversation.
    public let llmInclusionStatus: LlmInclusionStatus
    /// How often the knowledge base should be refreshed.
    public let refreshFrequency: KnowledgeBaseRefreshFrequency
    /// The IDs of the segment that must be matched for the knowledge base to be relevant to a conversation.
    /// Segments are replacing inline preconditions - a Knowledge Base may not have both an inline precondition and a segment.
    /// Inline precondition support will be removed in a future release.
    public let segmentId: EntityId?
    /// The IDs of the segments that should be matched for the knowledge base to be relevant to a conversation.
    /// Segments are replacing inline preconditions - a Knowledge Base may not have both an inline precondition and a segment.
    /// Inline precondition support will be removed in a future release.
    public let segmentIds: JSONValue
    /// The source URL of URL and RSS knowledge bases that was used for crawl.
    public let url: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        precondition: Precondition? = nil,
        createdAt: Date,
        updatedAt: Date,
        knowledgeBaseId: EntityId,
        activeVersionId: EntityId? = nil,
        mostRecentVersionStatus: KnowledgeBaseVersionStatus,
        type: KnowledgeBaseType,
        metadata: [String: String],
        tags: JSONValue,
        llmInclusionStatus: LlmInclusionStatus,
        refreshFrequency: KnowledgeBaseRefreshFrequency,
        segmentId: EntityId? = nil,
        segmentIds: JSONValue,
        url: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.precondition = precondition
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.knowledgeBaseId = knowledgeBaseId
        self.activeVersionId = activeVersionId
        self.mostRecentVersionStatus = mostRecentVersionStatus
        self.type = type
        self.metadata = metadata
        self.tags = tags
        self.llmInclusionStatus = llmInclusionStatus
        self.refreshFrequency = refreshFrequency
        self.segmentId = segmentId
        self.segmentIds = segmentIds
        self.url = url
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.precondition = try container.decodeIfPresent(Precondition.self, forKey: .precondition)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.knowledgeBaseId = try container.decode(EntityId.self, forKey: .knowledgeBaseId)
        self.activeVersionId = try container.decodeIfPresent(EntityId.self, forKey: .activeVersionId)
        self.mostRecentVersionStatus = try container.decode(KnowledgeBaseVersionStatus.self, forKey: .mostRecentVersionStatus)
        self.type = try container.decode(KnowledgeBaseType.self, forKey: .type)
        self.metadata = try container.decode([String: String].self, forKey: .metadata)
        self.tags = try container.decode(JSONValue.self, forKey: .tags)
        self.llmInclusionStatus = try container.decode(LlmInclusionStatus.self, forKey: .llmInclusionStatus)
        self.refreshFrequency = try container.decode(KnowledgeBaseRefreshFrequency.self, forKey: .refreshFrequency)
        self.segmentId = try container.decodeIfPresent(EntityId.self, forKey: .segmentId)
        self.segmentIds = try container.decode(JSONValue.self, forKey: .segmentIds)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.precondition, forKey: .precondition)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.updatedAt, forKey: .updatedAt)
        try container.encode(self.knowledgeBaseId, forKey: .knowledgeBaseId)
        try container.encodeIfPresent(self.activeVersionId, forKey: .activeVersionId)
        try container.encode(self.mostRecentVersionStatus, forKey: .mostRecentVersionStatus)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.metadata, forKey: .metadata)
        try container.encode(self.tags, forKey: .tags)
        try container.encode(self.llmInclusionStatus, forKey: .llmInclusionStatus)
        try container.encode(self.refreshFrequency, forKey: .refreshFrequency)
        try container.encodeIfPresent(self.segmentId, forKey: .segmentId)
        try container.encode(self.segmentIds, forKey: .segmentIds)
        try container.encodeIfPresent(self.url, forKey: .url)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case precondition
        case createdAt
        case updatedAt
        case knowledgeBaseId
        case activeVersionId
        case mostRecentVersionStatus
        case type
        case metadata
        case tags
        case llmInclusionStatus
        case refreshFrequency
        case segmentId
        case segmentIds
        case url
    }
}