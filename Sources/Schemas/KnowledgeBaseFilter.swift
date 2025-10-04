import Foundation

public struct KnowledgeBaseFilter: Codable, Hashable, Sendable {
    /// Full-text search query for matching knowledge bases by content. 
    /// When you search with this parameter, you're performing a full-text search across the knowledge title, tags and metadata.
    /// 
    /// This field also supports a syntax for advanced filtering the `metadata` field.           
    /// 
    /// Metadata examples:
    /// - `metadata:myvalue` - matches knowledge bases with any metadata field set to `myvalue`
    /// - `metadata.mykey:myvalue` - matches knowledge bases with a metadata field `mykey` set to `myvalue`
    /// - `metadata.mykey:myvalue OR anothervalue` - matches knowledge bases with a metadata field `mykey` set to `myvalue` or `anothervalue`
    /// - `metadata.mykey:*` - matches knowledge bases with a metadata field `mykey`
    /// - `-metadata:myvalue` - matches knowledge bases that do not have any metadata field set to `myvalue`
    /// - `_exists_:metadata` - matches knowledge bases that have any metadata field set
    public let search: String?
    /// Filter by title
    public let title: String?
    /// Filter knowledge bases created on or after this timestamp
    public let createdAfter: Date?
    /// Filter knowledge bases created on or before this timestamp
    public let createdBefore: Date?
    /// Filter by app IDs
    public let appIds: [String]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        search: String? = nil,
        title: String? = nil,
        createdAfter: Date? = nil,
        createdBefore: Date? = nil,
        appIds: [String]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.search = search
        self.title = title
        self.createdAfter = createdAfter
        self.createdBefore = createdBefore
        self.appIds = appIds
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.search = try container.decodeIfPresent(String.self, forKey: .search)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.createdAfter = try container.decodeIfPresent(Date.self, forKey: .createdAfter)
        self.createdBefore = try container.decodeIfPresent(Date.self, forKey: .createdBefore)
        self.appIds = try container.decodeIfPresent([String].self, forKey: .appIds)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.search, forKey: .search)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.createdAfter, forKey: .createdAfter)
        try container.encodeIfPresent(self.createdBefore, forKey: .createdBefore)
        try container.encodeIfPresent(self.appIds, forKey: .appIds)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case search
        case title
        case createdAfter
        case createdBefore
        case appIds
    }
}