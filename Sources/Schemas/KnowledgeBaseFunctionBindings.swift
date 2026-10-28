import Foundation

/// The three Function versions that sync a knowledge base, all in its own app.
public struct KnowledgeBaseFunctionBindings: Codable, Hashable, Sendable {
    /// Fetches the lookup data the other two Functions need, once per sync.
    public let fetchMetadata: FunctionVersionBinding
    /// Fetches one page of raw records from the source.
    public let fetchDocuments: FunctionVersionBinding
    /// Converts one page of raw records into documents.
    public let convertDocuments: FunctionVersionBinding
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        fetchMetadata: FunctionVersionBinding,
        fetchDocuments: FunctionVersionBinding,
        convertDocuments: FunctionVersionBinding,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.fetchMetadata = fetchMetadata
        self.fetchDocuments = fetchDocuments
        self.convertDocuments = convertDocuments
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fetchMetadata = try container.decode(FunctionVersionBinding.self, forKey: .fetchMetadata)
        self.fetchDocuments = try container.decode(FunctionVersionBinding.self, forKey: .fetchDocuments)
        self.convertDocuments = try container.decode(FunctionVersionBinding.self, forKey: .convertDocuments)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.fetchMetadata, forKey: .fetchMetadata)
        try container.encode(self.fetchDocuments, forKey: .fetchDocuments)
        try container.encode(self.convertDocuments, forKey: .convertDocuments)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case fetchMetadata
        case fetchDocuments
        case convertDocuments
    }
}