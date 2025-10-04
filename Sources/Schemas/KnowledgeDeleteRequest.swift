import Foundation

public struct KnowledgeDeleteRequest: Codable, Hashable, Sendable {
    /// ID that uniquely identifies which knowledge base version to delete the document from.
    public let versionId: EntityIdWithoutAgent
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        versionId: EntityIdWithoutAgent,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.versionId = versionId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.versionId = try container.decode(EntityIdWithoutAgent.self, forKey: .versionId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.versionId, forKey: .versionId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case versionId
    }
}