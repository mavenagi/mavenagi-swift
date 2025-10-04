import Foundation

public struct Organization: Codable, Hashable, Sendable {
    /// The name of the organization.
    public let name: String
    /// The default language for the organization in ISO 639-1 code format.
    public let defaultLanguage: String
    /// ID that uniquely identifies this organization
    public let organizationId: EntityIdBase
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        defaultLanguage: String,
        organizationId: EntityIdBase,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.defaultLanguage = defaultLanguage
        self.organizationId = organizationId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.defaultLanguage = try container.decode(String.self, forKey: .defaultLanguage)
        self.organizationId = try container.decode(EntityIdBase.self, forKey: .organizationId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.defaultLanguage, forKey: .defaultLanguage)
        try container.encode(self.organizationId, forKey: .organizationId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case defaultLanguage
        case organizationId
    }
}