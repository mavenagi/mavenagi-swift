import Foundation

public struct KnowledgeBaseVersionRequest: Codable, Hashable, Sendable {
    /// Indicates whether the completed version constitutes a full or partial refresh of the knowledge base. Deleting and updating documents is only supported for partial refreshes.
    public let type: KnowledgeBaseVersionType
    /// The Function versions that build this version. On a version, absent for historical versions and for versions created without them.
    public let functionVersions: KnowledgeBaseFunctionBindings?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: KnowledgeBaseVersionType,
        functionVersions: KnowledgeBaseFunctionBindings? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.functionVersions = functionVersions
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(KnowledgeBaseVersionType.self, forKey: .type)
        self.functionVersions = try container.decodeIfPresent(KnowledgeBaseFunctionBindings.self, forKey: .functionVersions)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.functionVersions, forKey: .functionVersions)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case functionVersions
    }
}