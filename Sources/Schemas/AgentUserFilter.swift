import Foundation

public struct AgentUserFilter: Codable, Hashable, Sendable {
    /// Full-text search query for matching agent users by content.
    /// When you search with this parameter, you're performing a full-text search across the user identifiers.
    public let search: String?
    /// Filter by identifiers
    public let identifiers: [String]?
    /// Full-text search query for matching agent users by display name.
    /// When you search with this parameter, you're performing a full-text search across the user display names.
    public let displayName: String?
    /// Filter by anonymous users. When true, only anonymous users are returned.
    /// When false, only non-anonymous users are returned. An anonymous user is one without any identifiers or name data.
    public let isAnonymous: Bool?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        search: String? = nil,
        identifiers: [String]? = nil,
        displayName: String? = nil,
        isAnonymous: Bool? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.search = search
        self.identifiers = identifiers
        self.displayName = displayName
        self.isAnonymous = isAnonymous
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.search = try container.decodeIfPresent(String.self, forKey: .search)
        self.identifiers = try container.decodeIfPresent([String].self, forKey: .identifiers)
        self.displayName = try container.decodeIfPresent(String.self, forKey: .displayName)
        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.search, forKey: .search)
        try container.encodeIfPresent(self.identifiers, forKey: .identifiers)
        try container.encodeIfPresent(self.displayName, forKey: .displayName)
        try container.encodeIfPresent(self.isAnonymous, forKey: .isAnonymous)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case search
        case identifiers
        case displayName
        case isAnonymous
    }
}