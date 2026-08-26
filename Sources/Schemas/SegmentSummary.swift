import Foundation

/// A lightweight segment representation containing identity, name, status, and precondition.
public struct SegmentSummary: Codable, Hashable, Sendable {
    /// ID that uniquely identifies this segment.
    public let segmentId: EntityId
    /// The display name of the segment.
    public let name: String
    /// The lifecycle status of the segment.
    public let status: SegmentStatus
    /// The precondition that must be met for a conversation message to match this segment.
    public let precondition: PreconditionResponse
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        segmentId: EntityId,
        name: String,
        status: SegmentStatus,
        precondition: PreconditionResponse,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.segmentId = segmentId
        self.name = name
        self.status = status
        self.precondition = precondition
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.segmentId = try container.decode(EntityId.self, forKey: .segmentId)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(SegmentStatus.self, forKey: .status)
        self.precondition = try container.decode(PreconditionResponse.self, forKey: .precondition)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.segmentId, forKey: .segmentId)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.precondition, forKey: .precondition)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case segmentId
        case name
        case status
        case precondition
    }
}