import Foundation

/// A charter that matched the conversation state during evaluation.
public struct BotLogicCharterDetail: Codable, Hashable, Sendable {
    /// The charter's entity ID.
    public let charterId: EntityIdWithoutAgent
    /// Human-readable charter name at the time of evaluation.
    public let name: String
    /// Deprecated, read the charter's `precondition` from the charters API instead.
    public let segmentId: EntityIdWithoutAgent?
    /// The parent charter in the hierarchy, if any. Absent for root-level charters.
    public let parentId: EntityIdWithoutAgent?
    /// The charter's type when the response was generated. A matched `STRICT_RETURN` charter's manual is the whole response.
    public let type: CharterType?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        charterId: EntityIdWithoutAgent,
        name: String,
        segmentId: EntityIdWithoutAgent? = nil,
        parentId: EntityIdWithoutAgent? = nil,
        type: CharterType? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.charterId = charterId
        self.name = name
        self.segmentId = segmentId
        self.parentId = parentId
        self.type = type
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.charterId = try container.decode(EntityIdWithoutAgent.self, forKey: .charterId)
        self.name = try container.decode(String.self, forKey: .name)
        self.segmentId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .segmentId)
        self.parentId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .parentId)
        self.type = try container.decodeIfPresent(CharterType.self, forKey: .type)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.charterId, forKey: .charterId)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.segmentId, forKey: .segmentId)
        try container.encodeIfPresent(self.parentId, forKey: .parentId)
        try container.encodeIfPresent(self.type, forKey: .type)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case charterId
        case name
        case segmentId
        case parentId
        case type
    }
}