import Foundation

public struct CancelKnowledgeBaseVersionRequest: Codable, Hashable, Sendable {
    /// The App ID of the knowledge base to cancel. If not provided the ID of the calling app will be used.
    public let appId: String?
    /// ID that uniquely identifies which knowledge base version to cancel. If not provided will use the most recent version of the knowledge base.
    public let versionId: EntityIdWithoutAgent?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        appId: String? = nil,
        versionId: EntityIdWithoutAgent? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.appId = appId
        self.versionId = versionId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
        self.versionId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .versionId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.appId, forKey: .appId)
        try container.encodeIfPresent(self.versionId, forKey: .versionId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case appId
        case versionId
    }
}