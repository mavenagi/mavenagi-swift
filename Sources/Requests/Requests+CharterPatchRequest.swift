import Foundation

extension Requests {
    public struct CharterPatchRequest: Codable, Hashable, Sendable {
        /// The App ID of the charter to update. If not provided, the ID of the calling app will be used.
        public let appId: String?
        /// The display name of the charter.
        public let name: String?
        /// A plain text description. Omit to leave unchanged.
        public let description: String?
        /// The instruction text. Omit to leave unchanged.
        public let manual: String?
        /// Move this charter to a new parent. Omit to leave the current parent unchanged.
        /// To promote this charter to root level instead, set the field explicitly to null.
        /// 
        /// The resulting tree must remain acyclic. A move that would make this charter its own
        /// ancestor is rejected with a 400 and leaves the tree unchanged.
        public let parentCharterId: Nullable<EntityId>?
        /// The rule controlling when this charter applies. Replaces the charter's existing
        /// rule outright -- this is not a merge. Set to null to make this charter a
        /// wildcard, removing the rule. Omit to leave unchanged.
        public let precondition: Nullable<Precondition>?
        /// The lifecycle status of this charter.
        public let status: CharterStatus?
        /// Whether this charter's children mutually exclude each other.
        /// Omit to leave unchanged.
        public let childrenExclusionPolicy: CharterChildrenExclusionPolicy?
        /// User-defined rank among siblings. When combined with `parentCharterId`,
        /// the rank is interpreted relative to the **new** sibling group, not the
        /// current one. Siblings in the destination at or above the target rank are
        /// shifted up by 1. Omit to keep the current rank value (which will still
        /// be applied to the new sibling group if `parentCharterId` is also changing).
        public let userRank: Int?
        /// Context items (knowledge bases and actions) this charter makes available.
        /// Each sub-field is independently optional — omit to leave unchanged.
        public let references: CharterPatchReferences?
        /// The agent variant this patch is scoped to. When set, the patch is staged in that
        /// variant's working set instead of being applied to the agent's live configuration.
        /// 
        /// Omit this field to patch the agent directly. Variant scoping is not active yet:
        /// a variant supplied today is accepted and ignored, and the patch applies to the
        /// agent.
        public let variantId: EntityIdWithoutAgent?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            appId: String? = nil,
            name: String? = nil,
            description: String? = nil,
            manual: String? = nil,
            parentCharterId: Nullable<EntityId>? = nil,
            precondition: Nullable<Precondition>? = nil,
            status: CharterStatus? = nil,
            childrenExclusionPolicy: CharterChildrenExclusionPolicy? = nil,
            userRank: Int? = nil,
            references: CharterPatchReferences? = nil,
            variantId: EntityIdWithoutAgent? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.appId = appId
            self.name = name
            self.description = description
            self.manual = manual
            self.parentCharterId = parentCharterId
            self.precondition = precondition
            self.status = status
            self.childrenExclusionPolicy = childrenExclusionPolicy
            self.userRank = userRank
            self.references = references
            self.variantId = variantId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.manual = try container.decodeIfPresent(String.self, forKey: .manual)
            self.parentCharterId = try container.decodeNullableIfPresent(EntityId.self, forKey: .parentCharterId)
            self.precondition = try container.decodeNullableIfPresent(Precondition.self, forKey: .precondition)
            self.status = try container.decodeIfPresent(CharterStatus.self, forKey: .status)
            self.childrenExclusionPolicy = try container.decodeIfPresent(CharterChildrenExclusionPolicy.self, forKey: .childrenExclusionPolicy)
            self.userRank = try container.decodeIfPresent(Int.self, forKey: .userRank)
            self.references = try container.decodeIfPresent(CharterPatchReferences.self, forKey: .references)
            self.variantId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .variantId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encodeIfPresent(self.appId, forKey: .appId)
            try container.encodeIfPresent(self.name, forKey: .name)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.manual, forKey: .manual)
            try container.encodeNullableIfPresent(self.parentCharterId, forKey: .parentCharterId)
            try container.encodeNullableIfPresent(self.precondition, forKey: .precondition)
            try container.encodeIfPresent(self.status, forKey: .status)
            try container.encodeIfPresent(self.childrenExclusionPolicy, forKey: .childrenExclusionPolicy)
            try container.encodeIfPresent(self.userRank, forKey: .userRank)
            try container.encodeIfPresent(self.references, forKey: .references)
            try container.encodeIfPresent(self.variantId, forKey: .variantId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case appId
            case name
            case description
            case manual
            case parentCharterId
            case precondition
            case status
            case childrenExclusionPolicy
            case userRank
            case references
            case variantId
        }
    }
}