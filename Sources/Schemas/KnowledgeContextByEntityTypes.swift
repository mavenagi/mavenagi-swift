import Foundation

public struct KnowledgeContextByEntityTypes: Codable, Hashable, Sendable {
    public let entityTypes: JSONValue
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        entityTypes: JSONValue,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.entityTypes = entityTypes
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.entityTypes = try container.decode(JSONValue.self, forKey: .entityTypes)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.entityTypes, forKey: .entityTypes)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case entityTypes
    }
}