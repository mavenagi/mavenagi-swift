import Foundation

public struct KnowledgeBaseVersionsListResponse: Codable, Hashable, Sendable {
    /// The active knowledge base versions for the knowledge base. Includes all versions within the last 90 days or the last 10, whichever is greater.
    public let knowledgeBaseVersions: [KnowledgeBaseVersion]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        knowledgeBaseVersions: [KnowledgeBaseVersion],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.knowledgeBaseVersions = knowledgeBaseVersions
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.knowledgeBaseVersions = try container.decode([KnowledgeBaseVersion].self, forKey: .knowledgeBaseVersions)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.knowledgeBaseVersions, forKey: .knowledgeBaseVersions)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case knowledgeBaseVersions
    }
}