import Foundation

extension Requests {
    public struct KnowledgeBasePatchRequest: Codable, Hashable, Sendable {
        /// The App ID of the knowledge base to patch. If not provided the ID of the calling app will be used.
        public let appId: String?
        /// The name of the knowledge base.
        public let name: String?
        /// The tags of the knowledge base.
        public let tags: JSONValue?
        /// Determines whether documents in the knowledge base are sent to the LLM as part of a conversation. Note that at this time knowledge bases can not be set to `ALWAYS`.
        public let llmInclusionStatus: LlmInclusionStatus?
        /// The preconditions that must be met for a knowledge base to be relevant to a conversation. Can be used to restrict knowledge bases to certain types of users. A null value will remove the precondition from the knowledge base, it will be available on all conversations.
        public let precondition: Nullable<Precondition>?
        /// The ID of a segment that must be matched for the knowledge base to be relevant to a conversation.
        /// A null value will remove the segment from the knowledge base, it will be available on all conversations.
        /// 
        /// Segments are replacing inline preconditions - a knowledge base may not have both an inline precondition and a segment.
        /// Inline precondition support will be removed in a future release.
        public let segmentId: Nullable<EntityId>?
        /// The IDs of segment that should be matched (under an OR clause) for the knowledge base to be relevant to a 
        /// conversation. An empty list will remove segments from the knowledge base, it will be available on all 
        /// conversations.
        /// Segments are replacing inline preconditions - a knowledge base may not have both an inline precondition and a segment.
        /// Inline precondition support will be removed in a future release.
        public let segmentIds: [EntityId]?
        /// How often the knowledge base should be refreshed.
        public let refreshFrequency: KnowledgeBaseRefreshFrequency?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            appId: String? = nil,
            name: String? = nil,
            tags: JSONValue? = nil,
            llmInclusionStatus: LlmInclusionStatus? = nil,
            precondition: Nullable<Precondition>? = nil,
            segmentId: Nullable<EntityId>? = nil,
            segmentIds: [EntityId]? = nil,
            refreshFrequency: KnowledgeBaseRefreshFrequency? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.appId = appId
            self.name = name
            self.tags = tags
            self.llmInclusionStatus = llmInclusionStatus
            self.precondition = precondition
            self.segmentId = segmentId
            self.segmentIds = segmentIds
            self.refreshFrequency = refreshFrequency
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.tags = try container.decodeIfPresent(JSONValue.self, forKey: .tags)
            self.llmInclusionStatus = try container.decodeIfPresent(LlmInclusionStatus.self, forKey: .llmInclusionStatus)
            self.precondition = try container.decodeNullableIfPresent(Precondition.self, forKey: .precondition)
            self.segmentId = try container.decodeNullableIfPresent(EntityId.self, forKey: .segmentId)
            self.segmentIds = try container.decodeIfPresent([EntityId].self, forKey: .segmentIds)
            self.refreshFrequency = try container.decodeIfPresent(KnowledgeBaseRefreshFrequency.self, forKey: .refreshFrequency)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encodeIfPresent(self.appId, forKey: .appId)
            try container.encodeIfPresent(self.name, forKey: .name)
            try container.encodeIfPresent(self.tags, forKey: .tags)
            try container.encodeIfPresent(self.llmInclusionStatus, forKey: .llmInclusionStatus)
            try container.encodeNullableIfPresent(self.precondition, forKey: .precondition)
            try container.encodeNullableIfPresent(self.segmentId, forKey: .segmentId)
            try container.encodeIfPresent(self.segmentIds, forKey: .segmentIds)
            try container.encodeIfPresent(self.refreshFrequency, forKey: .refreshFrequency)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case appId
            case name
            case tags
            case llmInclusionStatus
            case precondition
            case segmentId
            case segmentIds
            case refreshFrequency
        }
    }
}