import Foundation

public struct AddDocumentFixRequest: Codable, Hashable, Sendable {
    /// Knowledge document to be added by this request
    public let knowledgeDocumentRequest: KnowledgeDocumentRequest
    /// Reference id of the Knowledge Base the document will be added to. 
    /// The appId is inferred from the request. Apps can only add documents to their own knowledge bases.
    public let knowledgeBaseReferenceId: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        knowledgeDocumentRequest: KnowledgeDocumentRequest,
        knowledgeBaseReferenceId: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.knowledgeDocumentRequest = knowledgeDocumentRequest
        self.knowledgeBaseReferenceId = knowledgeBaseReferenceId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.knowledgeDocumentRequest = try container.decode(KnowledgeDocumentRequest.self, forKey: .knowledgeDocumentRequest)
        self.knowledgeBaseReferenceId = try container.decode(String.self, forKey: .knowledgeBaseReferenceId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.knowledgeDocumentRequest, forKey: .knowledgeDocumentRequest)
        try container.encode(self.knowledgeBaseReferenceId, forKey: .knowledgeBaseReferenceId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case knowledgeDocumentRequest
        case knowledgeBaseReferenceId
    }
}