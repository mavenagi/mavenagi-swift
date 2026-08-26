import Foundation

public struct SegmentRequest: Codable, Hashable, Sendable {
    /// The name of the segment.
    public let name: String
    /// A plain text description of the segment.
    public let description: String?
    /// ID that uniquely identifies this segment
    public let segmentId: EntityIdBase
    /// The agent variant this write is scoped to. When set, the segment content is staged in
    /// that variant's working set instead of being applied to the agent's live configuration.
    /// 
    /// Omit this field to write directly to the agent. Variant scoping is not active yet: a
    /// variant supplied today is accepted and ignored, and the write applies to the agent.
    public let variantId: EntityIdWithoutAgent?
    /// The precondition that must be met for a conversation message to be included in the segment.
    public let precondition: Precondition
    /// Desired status for the segment. If omitted, defaults to ACTIVE. In the future this will become required, so specify ACTIVE or INACTIVE if possible.
    public let status: SegmentStatus?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        description: String? = nil,
        segmentId: EntityIdBase,
        variantId: EntityIdWithoutAgent? = nil,
        precondition: Precondition,
        status: SegmentStatus? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.description = description
        self.segmentId = segmentId
        self.variantId = variantId
        self.precondition = precondition
        self.status = status
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.segmentId = try container.decode(EntityIdBase.self, forKey: .segmentId)
        self.variantId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .variantId)
        self.precondition = try container.decode(Precondition.self, forKey: .precondition)
        self.status = try container.decodeIfPresent(SegmentStatus.self, forKey: .status)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encode(self.segmentId, forKey: .segmentId)
        try container.encodeIfPresent(self.variantId, forKey: .variantId)
        try container.encode(self.precondition, forKey: .precondition)
        try container.encodeIfPresent(self.status, forKey: .status)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case description
        case segmentId
        case variantId
        case precondition
        case status
    }
}