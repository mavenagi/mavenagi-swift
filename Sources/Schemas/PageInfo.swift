import Foundation

public struct PageInfo: Codable, Hashable, Sendable {
    public let pageName: String?
    public let pageUrl: String?
    public let pageTitle: String?
    public let linkUrl: String?
    public let elementId: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        pageName: String? = nil,
        pageUrl: String? = nil,
        pageTitle: String? = nil,
        linkUrl: String? = nil,
        elementId: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.pageName = pageName
        self.pageUrl = pageUrl
        self.pageTitle = pageTitle
        self.linkUrl = linkUrl
        self.elementId = elementId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pageName = try container.decodeIfPresent(String.self, forKey: .pageName)
        self.pageUrl = try container.decodeIfPresent(String.self, forKey: .pageUrl)
        self.pageTitle = try container.decodeIfPresent(String.self, forKey: .pageTitle)
        self.linkUrl = try container.decodeIfPresent(String.self, forKey: .linkUrl)
        self.elementId = try container.decodeIfPresent(String.self, forKey: .elementId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.pageName, forKey: .pageName)
        try container.encodeIfPresent(self.pageUrl, forKey: .pageUrl)
        try container.encodeIfPresent(self.pageTitle, forKey: .pageTitle)
        try container.encodeIfPresent(self.linkUrl, forKey: .linkUrl)
        try container.encodeIfPresent(self.elementId, forKey: .elementId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case pageName
        case pageUrl
        case pageTitle
        case linkUrl
        case elementId
    }
}