import Foundation

public struct FinalizeKnowledgeBaseVersionRequest: Codable, Hashable, Sendable {
    /// ID that uniquely identifies which knowledge base version to finalize. If not provided will use the most recent version of the knowledge base.
    public let versionId: EntityIdWithoutAgent?
    /// Whether the knowledge base version processing was successful or not.
    public let status: KnowledgeBaseVersionFinalizeStatus?
    /// A user-facing error message that provides more details about a version failure.
    public let errorMessage: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        versionId: EntityIdWithoutAgent? = nil,
        status: KnowledgeBaseVersionFinalizeStatus? = nil,
        errorMessage: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.versionId = versionId
        self.status = status
        self.errorMessage = errorMessage
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.versionId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .versionId)
        self.status = try container.decodeIfPresent(KnowledgeBaseVersionFinalizeStatus.self, forKey: .status)
        self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.versionId, forKey: .versionId)
        try container.encodeIfPresent(self.status, forKey: .status)
        try container.encodeIfPresent(self.errorMessage, forKey: .errorMessage)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case versionId
        case status
        case errorMessage
    }
}