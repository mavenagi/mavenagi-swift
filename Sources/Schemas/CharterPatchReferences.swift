import Foundation

/// References to context items (knowledge bases and actions) a charter makes available.
/// Each field is independently optional — omit a field to leave that set unchanged.
public struct CharterPatchReferences: Codable, Hashable, Sendable {
    /// The knowledge bases this charter makes available, each optionally narrowed to a
    /// subset of that knowledge base's documents.
    /// Replaces the entire list when provided. Omit to leave unchanged.
    /// An empty list removes all knowledge base associations.
    /// At most one entry per knowledge base. Maximum 50 knowledge bases per charter.
    public let knowledgeBases: [CharterKnowledgeBaseReference]?
    /// The IDs of actions this charter makes available.
    /// Replaces the entire set when provided. Omit to leave unchanged.
    /// An empty set removes all action associations.
    /// Maximum 50 actions per charter.
    public let actionIds: JSONValue?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        knowledgeBases: [CharterKnowledgeBaseReference]? = nil,
        actionIds: JSONValue? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.knowledgeBases = knowledgeBases
        self.actionIds = actionIds
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.knowledgeBases = try container.decodeIfPresent([CharterKnowledgeBaseReference].self, forKey: .knowledgeBases)
        self.actionIds = try container.decodeIfPresent(JSONValue.self, forKey: .actionIds)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.knowledgeBases, forKey: .knowledgeBases)
        try container.encodeIfPresent(self.actionIds, forKey: .actionIds)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case knowledgeBases
        case actionIds
    }
}