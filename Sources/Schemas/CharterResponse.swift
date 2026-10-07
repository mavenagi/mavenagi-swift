import Foundation

public struct CharterResponse: Codable, Hashable, Sendable {
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
    /// ID that uniquely identifies this charter.
    public let charterId: EntityId
    /// The ID of the parent charter. Empty for root-level charters.
    /// 
    /// Charter hierarchies are acyclic, so following this field repeatedly always reaches a
    /// root-level charter in a finite number of steps. A charter is never its own ancestor, and
    /// callers walking the chain do not need their own cycle guard.
    public let parentCharterId: EntityId?
    /// The IDs of direct child charters, in their userRank order.
    public let childCharterIds: [EntityId]
    /// The rule controlling when this charter applies. Empty means wildcard (always matches).
    public let precondition: PreconditionResponse?
    /// The lifecycle status of this charter.
    public let status: CharterStatus
    /// The behavioral mode for this charter. Defaults to STANDARD.
    public let type: CharterType?
    /// Whether this charter's children mutually exclude each other. Defaults to DEFAULT.
    public let childrenExclusionPolicy: CharterChildrenExclusionPolicy?
    /// User-defined rank among siblings. Lower rank = higher priority. When multiple charters
    /// in the same leaf group match, the lowest-rank ACTIVE charter is applied.
    /// Auto-assigned as `max(siblings.userRank) + 1` (0 if no siblings) when not explicitly set.
    public let userRank: Int
    /// Context items (knowledge bases and actions) this charter makes available.
    public let references: CharterReferences
    /// The date and time this charter was created.
    public let createdAt: Date
    /// The date and time this charter was last updated.
    public let updatedAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        variantId: EntityIdWithoutAgent? = nil,
        description: String? = nil,
        manual: String? = nil,
        charterId: EntityId,
        parentCharterId: EntityId? = nil,
        childCharterIds: [EntityId],
        precondition: PreconditionResponse? = nil,
        status: CharterStatus,
        type: CharterType? = nil,
        childrenExclusionPolicy: CharterChildrenExclusionPolicy? = nil,
        userRank: Int,
        references: CharterReferences,
        createdAt: Date,
        updatedAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.variantId = variantId
        self.description = description
        self.manual = manual
        self.charterId = charterId
        self.parentCharterId = parentCharterId
        self.childCharterIds = childCharterIds
        self.precondition = precondition
        self.status = status
        self.type = type
        self.childrenExclusionPolicy = childrenExclusionPolicy
        self.userRank = userRank
        self.references = references
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.variantId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .variantId)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.manual = try container.decodeIfPresent(String.self, forKey: .manual)
        self.charterId = try container.decode(EntityId.self, forKey: .charterId)
        self.parentCharterId = try container.decodeIfPresent(EntityId.self, forKey: .parentCharterId)
        self.childCharterIds = try container.decode([EntityId].self, forKey: .childCharterIds)
        self.precondition = try container.decodeIfPresent(PreconditionResponse.self, forKey: .precondition)
        self.status = try container.decode(CharterStatus.self, forKey: .status)
        self.type = try container.decodeIfPresent(CharterType.self, forKey: .type)
        self.childrenExclusionPolicy = try container.decodeIfPresent(CharterChildrenExclusionPolicy.self, forKey: .childrenExclusionPolicy)
        self.userRank = try container.decode(Int.self, forKey: .userRank)
        self.references = try container.decode(CharterReferences.self, forKey: .references)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.variantId, forKey: .variantId)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.manual, forKey: .manual)
        try container.encode(self.charterId, forKey: .charterId)
        try container.encodeIfPresent(self.parentCharterId, forKey: .parentCharterId)
        try container.encode(self.childCharterIds, forKey: .childCharterIds)
        try container.encodeIfPresent(self.precondition, forKey: .precondition)
        try container.encode(self.status, forKey: .status)
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.childrenExclusionPolicy, forKey: .childrenExclusionPolicy)
        try container.encode(self.userRank, forKey: .userRank)
        try container.encode(self.references, forKey: .references)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.updatedAt, forKey: .updatedAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case variantId
        case description
        case manual
        case charterId
        case parentCharterId
        case childCharterIds
        case precondition
        case status
        case type
        case childrenExclusionPolicy
        case userRank
        case references
        case createdAt
        case updatedAt
    }
}