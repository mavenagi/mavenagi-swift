import Foundation

/// Narrows the apps returned by a directory search. Every field is optional; omitting all of them
/// returns every app visible to the agent. Fields combine with AND, and list fields match any of
/// their values.
public struct AppsFilter: Codable, Hashable, Sendable {
    /// Case-insensitive substring match against an app's id, name, or description.
    public let search: String?
    /// Only return apps with one of these visibilities.
    public let visibility: [AppVisibility]?
    /// Only return apps that are installed on this agent, or only those that are not. Omit to
    /// return both.
    public let installed: AppInstalled?
    /// Only return apps tagged with one of these categories.
    public let category: [AppCategory]?
    /// Only return apps offering one of these capabilities.
    public let capability: [AppCapability]?
    /// Also compute `allAppsCountByFilter` and `installedAppsCountByFilter` on the response.
    /// These are the counts a filter sidebar needs, and computing them costs extra queries, so
    /// they are off by default.
    public let filterCountEnabled: Bool?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        search: String? = nil,
        visibility: [AppVisibility]? = nil,
        installed: AppInstalled? = nil,
        category: [AppCategory]? = nil,
        capability: [AppCapability]? = nil,
        filterCountEnabled: Bool? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.search = search
        self.visibility = visibility
        self.installed = installed
        self.category = category
        self.capability = capability
        self.filterCountEnabled = filterCountEnabled
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.search = try container.decodeIfPresent(String.self, forKey: .search)
        self.visibility = try container.decodeIfPresent([AppVisibility].self, forKey: .visibility)
        self.installed = try container.decodeIfPresent(AppInstalled.self, forKey: .installed)
        self.category = try container.decodeIfPresent([AppCategory].self, forKey: .category)
        self.capability = try container.decodeIfPresent([AppCapability].self, forKey: .capability)
        self.filterCountEnabled = try container.decodeIfPresent(Bool.self, forKey: .filterCountEnabled)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.search, forKey: .search)
        try container.encodeIfPresent(self.visibility, forKey: .visibility)
        try container.encodeIfPresent(self.installed, forKey: .installed)
        try container.encodeIfPresent(self.category, forKey: .category)
        try container.encodeIfPresent(self.capability, forKey: .capability)
        try container.encodeIfPresent(self.filterCountEnabled, forKey: .filterCountEnabled)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case search
        case visibility
        case installed
        case category
        case capability
        case filterCountEnabled
    }
}