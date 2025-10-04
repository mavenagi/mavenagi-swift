import Foundation

public struct ApplyFixesRequest: Codable, Hashable, Sendable {
    /// The appId of the inbox item and fixes.
    public let appId: String
    /// A list of one or more reference IDs of fixes to apply. All must belong to the same inbox item.
    public let fixReferenceIds: [String]
    /// Only applies to add document fixes, includes the document content to save.
    public let addDocumentRequest: AddDocumentFixRequest?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        appId: String,
        fixReferenceIds: [String],
        addDocumentRequest: AddDocumentFixRequest? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.appId = appId
        self.fixReferenceIds = fixReferenceIds
        self.addDocumentRequest = addDocumentRequest
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appId = try container.decode(String.self, forKey: .appId)
        self.fixReferenceIds = try container.decode([String].self, forKey: .fixReferenceIds)
        self.addDocumentRequest = try container.decodeIfPresent(AddDocumentFixRequest.self, forKey: .addDocumentRequest)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.appId, forKey: .appId)
        try container.encode(self.fixReferenceIds, forKey: .fixReferenceIds)
        try container.encodeIfPresent(self.addDocumentRequest, forKey: .addDocumentRequest)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case appId
        case fixReferenceIds
        case addDocumentRequest
    }
}