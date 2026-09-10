import Foundation

/// Facet counts for the app directory's filter controls — how many apps would remain under each
/// individual filter value. Counts span every matching app, not only the current page.
public struct CountByFilterResult: Codable, Hashable, Sendable {
    /// Number of apps with each visibility.
    public let countByVisibility: [AppVisibility: Int]
    /// Number of apps in each category.
    public let countByCategory: [AppCategory: Int]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        countByVisibility: [AppVisibility: Int],
        countByCategory: [AppCategory: Int],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.countByVisibility = countByVisibility
        self.countByCategory = countByCategory
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.countByVisibility = try container.decode([AppVisibility: Int].self, forKey: .countByVisibility)
        self.countByCategory = try container.decode([AppCategory: Int].self, forKey: .countByCategory)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.countByVisibility, forKey: .countByVisibility)
        try container.encode(self.countByCategory, forKey: .countByCategory)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case countByVisibility
        case countByCategory
    }
}