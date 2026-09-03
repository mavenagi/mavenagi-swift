import Foundation

public struct ConversationsCursorSearchResponse: Codable, Hashable, Sendable {
    /// Pass this back as `cursor` to read the next page. Omitted when the traversal is
    /// complete. This is the only reliable end-of-results signal — a page can legitimately hold
    /// fewer items than `size` while more pages remain.
    public let nextCursor: String?
    /// The conversations that match the search criteria
    public let conversations: [ConversationPreview]
    /// The total number of matching conversations, returned only on the first page of a
    /// traversal and omitted on continuations — the count is paid for once. A snapshot taken
    /// when the traversal began; the underlying set may grow while you read.
    public let totalElements: Int64?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        nextCursor: String? = nil,
        conversations: [ConversationPreview],
        totalElements: Int64? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.nextCursor = nextCursor
        self.conversations = conversations
        self.totalElements = totalElements
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nextCursor = try container.decodeIfPresent(String.self, forKey: .nextCursor)
        self.conversations = try container.decode([ConversationPreview].self, forKey: .conversations)
        self.totalElements = try container.decodeIfPresent(Int64.self, forKey: .totalElements)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.nextCursor, forKey: .nextCursor)
        try container.encode(self.conversations, forKey: .conversations)
        try container.encodeIfPresent(self.totalElements, forKey: .totalElements)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case nextCursor
        case conversations
        case totalElements
    }
}