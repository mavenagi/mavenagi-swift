import Foundation

public struct BaseSearchRequest: Codable, Hashable, Sendable {
    /// Page number to return, defaults to 0
    public let page: Int?
    /// The size of the page to return, defaults to 20
    public let size: Int?
    /// Whether to sort descending, defaults to true
    public let sortDesc: Bool?
    /// The field to sort by, defaults to created timestamp
    public let sortId: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        page: Int? = nil,
        size: Int? = nil,
        sortDesc: Bool? = nil,
        sortId: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.page = page
        self.size = size
        self.sortDesc = sortDesc
        self.sortId = sortId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page)
        self.size = try container.decodeIfPresent(Int.self, forKey: .size)
        self.sortDesc = try container.decodeIfPresent(Bool.self, forKey: .sortDesc)
        self.sortId = try container.decodeIfPresent(String.self, forKey: .sortId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.page, forKey: .page)
        try container.encodeIfPresent(self.size, forKey: .size)
        try container.encodeIfPresent(self.sortDesc, forKey: .sortDesc)
        try container.encodeIfPresent(self.sortId, forKey: .sortId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case page
        case size
        case sortDesc
        case sortId
    }
}