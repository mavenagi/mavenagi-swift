import Foundation

public struct KnowledgeBaseRequest: Codable, Hashable, Sendable {
    /// The name of the knowledge base
    public let name: String
    /// The preconditions that must be met for knowledge base be relevant to a conversation. Can be used to restrict knowledge bases to certain types of users.
    public let precondition: Precondition?
    /// ID that uniquely identifies this knowledge base
    public let knowledgeBaseId: EntityIdBase
    /// Metadata for the knowledge base.
    public let metadata: [String: String]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        precondition: Precondition? = nil,
        knowledgeBaseId: EntityIdBase,
        metadata: [String: String]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.precondition = precondition
        self.knowledgeBaseId = knowledgeBaseId
        self.metadata = metadata
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.precondition = try container.decodeIfPresent(Precondition.self, forKey: .precondition)
        self.knowledgeBaseId = try container.decode(EntityIdBase.self, forKey: .knowledgeBaseId)
        self.metadata = try container.decodeIfPresent([String: String].self, forKey: .metadata)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.precondition, forKey: .precondition)
        try container.encode(self.knowledgeBaseId, forKey: .knowledgeBaseId)
        try container.encodeIfPresent(self.metadata, forKey: .metadata)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case precondition
        case knowledgeBaseId
        case metadata
    }
}