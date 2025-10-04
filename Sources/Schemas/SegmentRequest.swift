import Foundation

public struct SegmentRequest: Codable, Hashable, Sendable {
    /// The name of the segment.
    public let name: String
    /// The precondition that must be met for a conversation message to be included in the segment.
    public let precondition: Precondition
    /// ID that uniquely identifies this segment
    public let segmentId: EntityIdBase
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        precondition: Precondition,
        segmentId: EntityIdBase,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.precondition = precondition
        self.segmentId = segmentId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.precondition = try container.decode(Precondition.self, forKey: .precondition)
        self.segmentId = try container.decode(EntityIdBase.self, forKey: .segmentId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.precondition, forKey: .precondition)
        try container.encode(self.segmentId, forKey: .segmentId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case precondition
        case segmentId
    }
}