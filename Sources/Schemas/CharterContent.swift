import Foundation

/// A charter's full content: its text fields, its position in the tree, the rule controlling
/// when it applies, its lifecycle status and its references.
/// 
/// `parentCharterId` is `nullable`, not `optional`: null is meaningful -- root level -- and
/// distinct from absent.
public struct CharterContent: Codable, Hashable, Sendable {
    /// Display name for this charter or group.
    public let name: String
    /// ID of the agent variant this charter belongs to, if applicable.
    /// 
    /// While charters are versioned for the agent, a write is staged in this variant's
    /// working set rather than applied to the agent's live configuration, and a write that
    /// names no variant is rejected with `VARIANT_REQUIRED`. While they aren't, a write that
    /// names a variant is rejected. An unknown variant is a 404.
    public let variantId: EntityIdWithoutAgent?
    /// A plain text description of this charter. If not set, existing description is preserved if present.
    public let description: String?
    /// Optional additional natural language instruction text when this
    /// charter matches. Manuals concatenate with ancestor charter manuals
    /// before delivery.
    /// 
    /// If not set, existing manual is preserved if present.
    public let manual: String?
    /// The fully-qualified ID of the parent charter. Send null to place this charter at the
    /// root level -- the field is nullable rather than optional, so null is meaningful and
    /// distinct from absent.
    /// 
    /// The resulting tree must remain acyclic. A write that would make this charter its own
    /// ancestor is rejected with a 400 and leaves the tree unchanged.
    public let parentCharterId: Nullable<EntityId>
    /// The rule controlling when this charter applies. Preconditions on
    /// ancestor charters are AND'd together with this charter's own
    /// precondition to determine whether there is a match. When null, the
    /// charter is a wildcard and always matches (subject to ancestor
    /// preconditions still combining with AND logic).
    public let precondition: Nullable<Precondition>?
    /// Desired lifecycle status.
    public let status: CharterStatus
    /// The behavioral mode for this charter. Defaults to STANDARD when omitted.
    /// 
    /// Set at creation and immutable afterward. When updating an existing charter (via
    /// createOrUpdate), this field must either be omitted or repeat the charter's current
    /// type — a differing value is rejected. There is no way to change a charter's type once
    /// created. (Recreating a deleted charter is a create, so it may pick any type.)
    /// 
    /// STRICT_RETURN charters cannot have children, and reference neither knowledge bases nor
    /// actions: no charter may name a STRICT_RETURN charter as its parent.
    public let type: CharterType?
    /// User-defined 0-indexed rank among siblings.
    /// 
    /// The rank is currently only meaningful for leaf charters as we enforce
    /// mutual exclusion among the leafs and pick only the highest ranked
    /// (lowest numerical value) leaf to include in the round. userRank may have
    /// gaps.
    /// 
    /// Lower rank = higher priority. When provided and conflicts with an
    /// existing sibling, siblings at that rank and above are shifted up by 1
    /// (like linked list semantics). When omitted on create, auto-assigned as
    /// `max(siblings.userRank) + 1` (0 if no siblings).
    public let userRank: Int?
    /// Context items (knowledge bases and actions) this charter makes available.
    /// Maximum 50 knowledge bases and 50 actions per charter.
    public let references: CharterReferences
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        variantId: EntityIdWithoutAgent? = nil,
        description: String? = nil,
        manual: String? = nil,
        parentCharterId: Nullable<EntityId>,
        precondition: Nullable<Precondition>? = nil,
        status: CharterStatus,
        type: CharterType? = nil,
        userRank: Int? = nil,
        references: CharterReferences,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.variantId = variantId
        self.description = description
        self.manual = manual
        self.parentCharterId = parentCharterId
        self.precondition = precondition
        self.status = status
        self.type = type
        self.userRank = userRank
        self.references = references
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.variantId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .variantId)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.manual = try container.decodeIfPresent(String.self, forKey: .manual)
        self.parentCharterId = try container.decode(Nullable<EntityId>.self, forKey: .parentCharterId)
        self.precondition = try container.decodeNullableIfPresent(Precondition.self, forKey: .precondition)
        self.status = try container.decode(CharterStatus.self, forKey: .status)
        self.type = try container.decodeIfPresent(CharterType.self, forKey: .type)
        self.userRank = try container.decodeIfPresent(Int.self, forKey: .userRank)
        self.references = try container.decode(CharterReferences.self, forKey: .references)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.variantId, forKey: .variantId)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.manual, forKey: .manual)
        try container.encode(self.parentCharterId, forKey: .parentCharterId)
        try container.encodeNullableIfPresent(self.precondition, forKey: .precondition)
        try container.encode(self.status, forKey: .status)
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.userRank, forKey: .userRank)
        try container.encode(self.references, forKey: .references)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case variantId
        case description
        case manual
        case parentCharterId
        case precondition
        case status
        case type
        case userRank
        case references
    }
}