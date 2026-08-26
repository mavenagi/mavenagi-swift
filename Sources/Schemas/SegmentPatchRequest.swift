import Foundation

public struct SegmentPatchRequest: Codable, Hashable, Sendable {
    /// The App ID of the segment to update. If not provided, the ID of the calling app will be used.
    public let appId: String?
    /// The name of the segment.
    public let name: String?
    /// A plain text description of the segment.
    public let description: String?
    /// The precondition that must be met for a conversation message to be included in the segment.
    public let precondition: Precondition?
    /// The status of the segment. Segments can only be deactivated if they are not set on any actions or active knowledge bases.
    public let status: SegmentStatus?
    /// The agent variant this patch is scoped to. When set, the patch is staged in that
    /// variant's working set instead of being applied to the agent's live configuration.
    /// 
    /// Omit this field to patch the agent directly. Variant scoping is not active yet: a
    /// variant supplied today is accepted and ignored, and the patch applies to the agent.
    public let variantId: EntityIdWithoutAgent?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        appId: String? = nil,
        name: String? = nil,
        description: String? = nil,
        precondition: Precondition? = nil,
        status: SegmentStatus? = nil,
        variantId: EntityIdWithoutAgent? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.appId = appId
        self.name = name
        self.description = description
        self.precondition = precondition
        self.status = status
        self.variantId = variantId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.precondition = try container.decodeIfPresent(Precondition.self, forKey: .precondition)
        self.status = try container.decodeIfPresent(SegmentStatus.self, forKey: .status)
        self.variantId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .variantId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.appId, forKey: .appId)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.precondition, forKey: .precondition)
        try container.encodeIfPresent(self.status, forKey: .status)
        try container.encodeIfPresent(self.variantId, forKey: .variantId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case appId
        case name
        case description
        case precondition
        case status
        case variantId
    }
}