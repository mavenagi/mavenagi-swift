import Foundation

/// Pagination parameters for endpoints traversed by an opaque cursor rather than by page offset.
/// Defined as a sibling of BasePaginatedRequest, not a subtype: a cursor traversal has no page
/// number, and offering `page` alongside `cursor` would let a caller send a self-contradictory
/// request. The 200 ceiling is tighter than either offset variant because cursor traversal is
/// designed to walk a whole result set in many small pages.
public struct BaseCursorRequest: Codable, Hashable, Sendable {
    /// The size of the page to return, defaults to 20. Max 200.
    public let size: Int?
    /// Whether to sort descending, defaults to true
    public let sortDesc: Bool?
    /// Opaque cursor from the previous response's `nextCursor`, passed back unchanged. Omit it to
    /// start a new traversal. Every other field must stay identical for the whole traversal;
    /// changing one is rejected rather than silently restarting from the beginning. Cursors have
    /// no expiry, but a cursor can still be rejected with a 400 if the server's signing key has
    /// since been rotated out; if that happens, discard it and restart the traversal.
    public let cursor: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        size: Int? = nil,
        sortDesc: Bool? = nil,
        cursor: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.size = size
        self.sortDesc = sortDesc
        self.cursor = cursor
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.size = try container.decodeIfPresent(Int.self, forKey: .size)
        self.sortDesc = try container.decodeIfPresent(Bool.self, forKey: .sortDesc)
        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.size, forKey: .size)
        try container.encodeIfPresent(self.sortDesc, forKey: .sortDesc)
        try container.encodeIfPresent(self.cursor, forKey: .cursor)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case size
        case sortDesc
        case cursor
    }
}