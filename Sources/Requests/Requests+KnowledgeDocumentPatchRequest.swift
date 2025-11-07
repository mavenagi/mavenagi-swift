import Foundation

extension Requests {
    public struct KnowledgeDocumentPatchRequest: Codable, Hashable, Sendable {
        /// The App ID of the knowledge base that contains the knowledge document to patch. If not provided the ID of the calling app will be used.
        public let knowledgeBaseAppId: String?
        /// Determines whether this document is sent to the LLM as part of a conversation.
        public let llmInclusionStatus: LlmInclusionStatus?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            knowledgeBaseAppId: String? = nil,
            llmInclusionStatus: LlmInclusionStatus? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.knowledgeBaseAppId = knowledgeBaseAppId
            self.llmInclusionStatus = llmInclusionStatus
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.knowledgeBaseAppId = try container.decodeIfPresent(String.self, forKey: .knowledgeBaseAppId)
            self.llmInclusionStatus = try container.decodeIfPresent(LlmInclusionStatus.self, forKey: .llmInclusionStatus)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encodeIfPresent(self.knowledgeBaseAppId, forKey: .knowledgeBaseAppId)
            try container.encodeIfPresent(self.llmInclusionStatus, forKey: .llmInclusionStatus)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case knowledgeBaseAppId
            case llmInclusionStatus
        }
    }
}