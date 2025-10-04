import Foundation

public struct BotLogicSegmentsItem: Codable, Hashable, Sendable {
    public let matchingSegmentIds: [EntityId]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        matchingSegmentIds: [EntityId],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.matchingSegmentIds = matchingSegmentIds
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.matchingSegmentIds = try container.decode([EntityId].self, forKey: .matchingSegmentIds)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.matchingSegmentIds, forKey: .matchingSegmentIds)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case matchingSegmentIds
    }
}