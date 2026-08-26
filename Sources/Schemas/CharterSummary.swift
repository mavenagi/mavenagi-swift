import Foundation

/// A lightweight charter representation for search results and ancestor paths.
/// Use the get endpoint to retrieve the full charter with references, manual, and children.
public struct CharterSummary: Codable, Hashable, Sendable {
    /// ID that uniquely identifies this charter.
    public let charterId: EntityId
    /// The display name of the charter.
    public let name: String
    /// The segment controlling when this charter applies. Null means wildcard
    /// (always matches).
    public let segmentSummary: Nullable<SegmentSummary>
    /// The ID of the parent charter. Null for root-level charters.
    public let parentCharterId: Nullable<EntityId>
    /// The lifecycle status of this charter.
    public let status: CharterStatus
    /// The behavioral mode for this charter. Defaults to STANDARD.
    public let type: CharterType?
    /// Whether this charter's children mutually exclude each other. Defaults to DEFAULT.
    public let childrenExclusionPolicy: CharterChildrenExclusionPolicy?
    /// The date and time this charter was created.
    public let createdAt: Date
    /// The date and time this charter was last updated.
    public let updatedAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        charterId: EntityId,
        name: String,
        segmentSummary: Nullable<SegmentSummary>,
        parentCharterId: Nullable<EntityId>,
        status: CharterStatus,
        type: CharterType? = nil,
        childrenExclusionPolicy: CharterChildrenExclusionPolicy? = nil,
        createdAt: Date,
        updatedAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.charterId = charterId
        self.name = name
        self.segmentSummary = segmentSummary
        self.parentCharterId = parentCharterId
        self.status = status
        self.type = type
        self.childrenExclusionPolicy = childrenExclusionPolicy
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.charterId = try container.decode(EntityId.self, forKey: .charterId)
        self.name = try container.decode(String.self, forKey: .name)
        self.segmentSummary = try container.decode(Nullable<SegmentSummary>.self, forKey: .segmentSummary)
        self.parentCharterId = try container.decode(Nullable<EntityId>.self, forKey: .parentCharterId)
        self.status = try container.decode(CharterStatus.self, forKey: .status)
        self.type = try container.decodeIfPresent(CharterType.self, forKey: .type)
        self.childrenExclusionPolicy = try container.decodeIfPresent(CharterChildrenExclusionPolicy.self, forKey: .childrenExclusionPolicy)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.charterId, forKey: .charterId)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.segmentSummary, forKey: .segmentSummary)
        try container.encode(self.parentCharterId, forKey: .parentCharterId)
        try container.encode(self.status, forKey: .status)
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.childrenExclusionPolicy, forKey: .childrenExclusionPolicy)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.updatedAt, forKey: .updatedAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case charterId
        case name
        case segmentSummary
        case parentCharterId
        case status
        case type
        case childrenExclusionPolicy
        case createdAt
        case updatedAt
    }
}