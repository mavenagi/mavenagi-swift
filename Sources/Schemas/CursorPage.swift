import Foundation

/// Pagination metadata for a cursor traversal. The counterpart to Page, which describes an
/// offset-paginated response.
public struct CursorPage: Codable, Hashable, Sendable {
    /// Pass this back as `cursor` to read the next page. Omitted when the traversal is
    /// complete. This is the only reliable end-of-results signal — a page can legitimately hold
    /// fewer items than `size` while more pages remain.
    public let nextCursor: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        nextCursor: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.nextCursor = nextCursor
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nextCursor = try container.decodeIfPresent(String.self, forKey: .nextCursor)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.nextCursor, forKey: .nextCursor)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case nextCursor
    }
}