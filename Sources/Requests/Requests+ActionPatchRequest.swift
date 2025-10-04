import Foundation

extension Requests {
    public struct ActionPatchRequest: Codable, Hashable, Sendable {
        /// The App ID of the action to patch. If not provided the ID of the calling app will be used.
        public let appId: String?
        /// The instructions given to the LLM when determining whether to execute the action.
        public let instructions: String?
        /// Determines whether the action is sent to the LLM as part of a conversation.
        public let llmInclusionStatus: LlmInclusionStatus?
        /// The ID of the segment that must be matched for the action to be relevant to a conversation. 
        /// A null value will remove the segment from the action, it will be available on all conversations.
        /// 
        /// Segments are replacing inline preconditions - an action may not have both an inline precondition and a segment.
        /// Inline precondition support will be removed in a future release.
        public let segmentId: Nullable<EntityId>?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            appId: String? = nil,
            instructions: String? = nil,
            llmInclusionStatus: LlmInclusionStatus? = nil,
            segmentId: Nullable<EntityId>? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.appId = appId
            self.instructions = instructions
            self.llmInclusionStatus = llmInclusionStatus
            self.segmentId = segmentId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
            self.instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
            self.llmInclusionStatus = try container.decodeIfPresent(LlmInclusionStatus.self, forKey: .llmInclusionStatus)
            self.segmentId = try container.decodeNullableIfPresent(EntityId.self, forKey: .segmentId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encodeIfPresent(self.appId, forKey: .appId)
            try container.encodeIfPresent(self.instructions, forKey: .instructions)
            try container.encodeIfPresent(self.llmInclusionStatus, forKey: .llmInclusionStatus)
            try container.encodeNullableIfPresent(self.segmentId, forKey: .segmentId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case appId
            case instructions
            case llmInclusionStatus
            case segmentId
        }
    }
}