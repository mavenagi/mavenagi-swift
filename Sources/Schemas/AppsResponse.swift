import Foundation

public struct AppsResponse: Codable, Hashable, Sendable {
    /// The page being returned, starts at 0
    public let number: Int
    /// The number of elements in this page
    public let size: Int
    /// The total number of elements in the collection
    public let totalElements: Int64
    /// The total number of pages in the collection
    public let totalPages: Int
    /// The page of apps matching the filter.
    public let apps: [MarketplaceApp]
    /// How many apps fall into each visibility and category, across everything visible to the
    /// agent rather than just this page. Present only when `filterCountEnabled` was set.
    public let allAppsCountByFilter: CountByFilterResult?
    /// The same breakdown restricted to apps installed on this agent. Present only when
    /// `filterCountEnabled` was set.
    public let installedAppsCountByFilter: CountByFilterResult?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        number: Int,
        size: Int,
        totalElements: Int64,
        totalPages: Int,
        apps: [MarketplaceApp],
        allAppsCountByFilter: CountByFilterResult? = nil,
        installedAppsCountByFilter: CountByFilterResult? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.number = number
        self.size = size
        self.totalElements = totalElements
        self.totalPages = totalPages
        self.apps = apps
        self.allAppsCountByFilter = allAppsCountByFilter
        self.installedAppsCountByFilter = installedAppsCountByFilter
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.number = try container.decode(Int.self, forKey: .number)
        self.size = try container.decode(Int.self, forKey: .size)
        self.totalElements = try container.decode(Int64.self, forKey: .totalElements)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.apps = try container.decode([MarketplaceApp].self, forKey: .apps)
        self.allAppsCountByFilter = try container.decodeIfPresent(CountByFilterResult.self, forKey: .allAppsCountByFilter)
        self.installedAppsCountByFilter = try container.decodeIfPresent(CountByFilterResult.self, forKey: .installedAppsCountByFilter)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.number, forKey: .number)
        try container.encode(self.size, forKey: .size)
        try container.encode(self.totalElements, forKey: .totalElements)
        try container.encode(self.totalPages, forKey: .totalPages)
        try container.encode(self.apps, forKey: .apps)
        try container.encodeIfPresent(self.allAppsCountByFilter, forKey: .allAppsCountByFilter)
        try container.encodeIfPresent(self.installedAppsCountByFilter, forKey: .installedAppsCountByFilter)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case number
        case size
        case totalElements
        case totalPages
        case apps
        case allAppsCountByFilter
        case installedAppsCountByFilter
    }
}