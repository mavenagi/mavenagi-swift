import Foundation

public struct SegmentResponse: Codable, Hashable, Sendable {
    /// The name of the segment.
    public let name: String
    /// The precondition that must be met for a conversation message to be included in the segment.
    public let precondition: Precondition
    /// ID that uniquely identifies this segment
    public let segmentId: EntityId
    /// Whether or not the segment is in active use. To preserve historical data, segments can not be deleted.
    /// 
    /// Only active segments will be evaluated for matching user questions.
    public let status: SegmentStatus
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        precondition: Precondition,
        segmentId: EntityId,
        status: SegmentStatus,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.precondition = precondition
        self.segmentId = segmentId
        self.status = status
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.precondition = try container.decode(Precondition.self, forKey: .precondition)
        self.segmentId = try container.decode(EntityId.self, forKey: .segmentId)
        self.status = try container.decode(SegmentStatus.self, forKey: .status)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.precondition, forKey: .precondition)
        try container.encode(self.segmentId, forKey: .segmentId)
        try container.encode(self.status, forKey: .status)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case precondition
        case segmentId
        case status
    }
}