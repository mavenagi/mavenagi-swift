import Foundation

/// A knowledge base a charter makes available, and optionally which of its documents.
public struct CharterKnowledgeBaseReference: Codable, Hashable, Sendable {
    /// The knowledge base this charter makes available.
    public let knowledgeBaseId: EntityId
    /// Narrows this reference to the documents in the knowledge base whose `metadata`
    /// satisfies this filter. Omit to reference every document in the knowledge base.
    /// 
    /// An entry's `key` is a metadata key on the document. A document carrying no such
    /// key matches only `presence` `IS_UNDETERMINED`.
    public let documentFilter: MetadataFilter?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        knowledgeBaseId: EntityId,
        documentFilter: MetadataFilter? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.knowledgeBaseId = knowledgeBaseId
        self.documentFilter = documentFilter
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.knowledgeBaseId = try container.decode(EntityId.self, forKey: .knowledgeBaseId)
        self.documentFilter = try container.decodeIfPresent(MetadataFilter.self, forKey: .documentFilter)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.knowledgeBaseId, forKey: .knowledgeBaseId)
        try container.encodeIfPresent(self.documentFilter, forKey: .documentFilter)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case knowledgeBaseId
        case documentFilter
    }
}