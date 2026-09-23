import Foundation

/// Context items (knowledge bases and actions) a charter makes available.
public struct CharterReferences: Codable, Hashable, Sendable {
    /// The knowledge bases this charter makes available, each optionally narrowed to a
    /// subset of that knowledge base's documents.
    /// 
    /// At most one entry per knowledge base. Maximum 50 knowledge bases per charter.
    /// 
    /// On a write, supplying this replaces the charter's whole knowledge base set. A response
    /// always populates it.
    public let knowledgeBases: [CharterKnowledgeBaseReference]?
    /// The IDs of actions this charter makes available.
    /// Maximum 50 actions per charter.
    public let actionIds: JSONValue
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        knowledgeBases: [CharterKnowledgeBaseReference]? = nil,
        actionIds: JSONValue,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.knowledgeBases = knowledgeBases
        self.actionIds = actionIds
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.knowledgeBases = try container.decodeIfPresent([CharterKnowledgeBaseReference].self, forKey: .knowledgeBases)
        self.actionIds = try container.decode(JSONValue.self, forKey: .actionIds)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.knowledgeBases, forKey: .knowledgeBases)
        try container.encode(self.actionIds, forKey: .actionIds)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case knowledgeBases
        case actionIds
    }
}