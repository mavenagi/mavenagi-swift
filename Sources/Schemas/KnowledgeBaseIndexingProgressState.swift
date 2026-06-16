import Foundation

public struct KnowledgeBaseIndexingProgressState: Codable, Hashable, Sendable {
    /// The unique ID of a knowledge base version.
    public let versionId: EntityId
    /// The status of the knowledge base indexing process.
    public let status: KnowledgeBaseIndexingStatus
    /// The expected number of documents to be indexed for the latest knowledge base version.
    public let expectedCount: Int64
    /// The number of documents that have been indexed so far for the latest knowledge base version.
    public let indexedCount: Int64
    /// The number of documents that have failed to index for the latest knowledge base version.
    public let failedCount: Int64
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        versionId: EntityId,
        status: KnowledgeBaseIndexingStatus,
        expectedCount: Int64,
        indexedCount: Int64,
        failedCount: Int64,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.versionId = versionId
        self.status = status
        self.expectedCount = expectedCount
        self.indexedCount = indexedCount
        self.failedCount = failedCount
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.versionId = try container.decode(EntityId.self, forKey: .versionId)
        self.status = try container.decode(KnowledgeBaseIndexingStatus.self, forKey: .status)
        self.expectedCount = try container.decode(Int64.self, forKey: .expectedCount)
        self.indexedCount = try container.decode(Int64.self, forKey: .indexedCount)
        self.failedCount = try container.decode(Int64.self, forKey: .failedCount)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.versionId, forKey: .versionId)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.expectedCount, forKey: .expectedCount)
        try container.encode(self.indexedCount, forKey: .indexedCount)
        try container.encode(self.failedCount, forKey: .failedCount)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case versionId
        case status
        case expectedCount
        case indexedCount
        case failedCount
    }
}