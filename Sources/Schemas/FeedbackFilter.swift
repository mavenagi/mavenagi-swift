import Foundation

public struct FeedbackFilter: Codable, Hashable, Sendable {
    public let search: String?
    public let createdAfter: Date?
    public let createdBefore: Date?
    public let users: [String]?
    public let apps: [String]?
    public let types: [FeedbackType]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        search: String? = nil,
        createdAfter: Date? = nil,
        createdBefore: Date? = nil,
        users: [String]? = nil,
        apps: [String]? = nil,
        types: [FeedbackType]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.search = search
        self.createdAfter = createdAfter
        self.createdBefore = createdBefore
        self.users = users
        self.apps = apps
        self.types = types
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.search = try container.decodeIfPresent(String.self, forKey: .search)
        self.createdAfter = try container.decodeIfPresent(Date.self, forKey: .createdAfter)
        self.createdBefore = try container.decodeIfPresent(Date.self, forKey: .createdBefore)
        self.users = try container.decodeIfPresent([String].self, forKey: .users)
        self.apps = try container.decodeIfPresent([String].self, forKey: .apps)
        self.types = try container.decodeIfPresent([FeedbackType].self, forKey: .types)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.search, forKey: .search)
        try container.encodeIfPresent(self.createdAfter, forKey: .createdAfter)
        try container.encodeIfPresent(self.createdBefore, forKey: .createdBefore)
        try container.encodeIfPresent(self.users, forKey: .users)
        try container.encodeIfPresent(self.apps, forKey: .apps)
        try container.encodeIfPresent(self.types, forKey: .types)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case search
        case createdAfter
        case createdBefore
        case users
        case apps
        case types
    }
}