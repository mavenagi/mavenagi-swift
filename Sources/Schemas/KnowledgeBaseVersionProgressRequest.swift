import Foundation

public struct KnowledgeBaseVersionProgressRequest: Codable, Hashable, Sendable {
    /// The App ID of the knowledge base to report progress for. If not provided the ID of the calling app will be used.
    public let appId: String?
    /// ID that uniquely identifies which knowledge base version to report progress for.
    public let versionId: EntityIdWithoutAgent
    /// The progress state to store on the version, replacing any previously reported progress.
    public let progress: KnowledgeBaseVersionProgress
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        appId: String? = nil,
        versionId: EntityIdWithoutAgent,
        progress: KnowledgeBaseVersionProgress,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.appId = appId
        self.versionId = versionId
        self.progress = progress
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
        self.versionId = try container.decode(EntityIdWithoutAgent.self, forKey: .versionId)
        self.progress = try container.decode(KnowledgeBaseVersionProgress.self, forKey: .progress)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.appId, forKey: .appId)
        try container.encode(self.versionId, forKey: .versionId)
        try container.encode(self.progress, forKey: .progress)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case appId
        case versionId
        case progress
    }
}