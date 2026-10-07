import Foundation

public struct CharterBase: Codable, Hashable, Sendable {
    /// Display name for this charter or group.
    public let name: String
    /// ID of the agent variant this charter belongs to, if applicable.
    /// 
    /// On a write this is validated -- an unknown variant is rejected, as is any
    /// variant while variant scoping is off for charters -- but not yet applied: the
    /// write reaches the agent's live configuration either way.
    public let variantId: EntityIdWithoutAgent?
    /// A plain text description of this charter. If not set, existing description is preserved if present.
    public let description: String?
    /// Optional additional natural language instruction text when this
    /// charter matches. Manuals concatenate with ancestor charter manuals
    /// before delivery.
    /// 
    /// If not set, existing manual is preserved if present.
    public let manual: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        variantId: EntityIdWithoutAgent? = nil,
        description: String? = nil,
        manual: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.variantId = variantId
        self.description = description
        self.manual = manual
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.variantId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .variantId)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.manual = try container.decodeIfPresent(String.self, forKey: .manual)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.variantId, forKey: .variantId)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.manual, forKey: .manual)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case variantId
        case description
        case manual
    }
}