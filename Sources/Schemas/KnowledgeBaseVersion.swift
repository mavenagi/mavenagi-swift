import Foundation

public struct KnowledgeBaseVersion: Codable, Hashable, Sendable {
    /// Indicates whether the completed version constitutes a full or partial refresh of the knowledge base. Deleting and updating documents is only supported for partial refreshes.
    public let type: KnowledgeBaseVersionType
    /// The unique ID of the knowledge base version.
    public let versionId: EntityId
    /// The status of the knowledge base version
    public let status: KnowledgeBaseVersionStatus
    /// A user-facing error message that provides more details about a version failure.
    public let errorMessage: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: KnowledgeBaseVersionType,
        versionId: EntityId,
        status: KnowledgeBaseVersionStatus,
        errorMessage: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.versionId = versionId
        self.status = status
        self.errorMessage = errorMessage
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(KnowledgeBaseVersionType.self, forKey: .type)
        self.versionId = try container.decode(EntityId.self, forKey: .versionId)
        self.status = try container.decode(KnowledgeBaseVersionStatus.self, forKey: .status)
        self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.versionId, forKey: .versionId)
        try container.encode(self.status, forKey: .status)
        try container.encodeIfPresent(self.errorMessage, forKey: .errorMessage)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case versionId
        case status
        case errorMessage
    }
}