import Foundation

/// How a knowledge base version changed the knowledge base, relative to the version that was
/// published when it finalized.
/// 
/// Documents are identified by their reference ID, so re-sending a document with changed content
/// counts as an update rather than as an add plus a remove. A full refresh removes a document
/// implicitly, by not including it.
public struct KnowledgeBaseDocumentDeltas: Codable, Hashable, Sendable {
    /// The number of documents this version added.
    public let addedCount: Int64
    /// The number of documents this version replaced with new content.
    public let updatedCount: Int64
    /// The number of documents this version removed.
    public let removedCount: Int64
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        addedCount: Int64,
        updatedCount: Int64,
        removedCount: Int64,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.addedCount = addedCount
        self.updatedCount = updatedCount
        self.removedCount = removedCount
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.addedCount = try container.decode(Int64.self, forKey: .addedCount)
        self.updatedCount = try container.decode(Int64.self, forKey: .updatedCount)
        self.removedCount = try container.decode(Int64.self, forKey: .removedCount)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.addedCount, forKey: .addedCount)
        try container.encode(self.updatedCount, forKey: .updatedCount)
        try container.encode(self.removedCount, forKey: .removedCount)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case addedCount
        case updatedCount
        case removedCount
    }
}