import Foundation

public struct InboxItemFixAddDocument: Codable, Hashable, Sendable {
    /// Unique identifier for the inbox item fix.
    public let id: EntityId
    /// Suggested document title if the fix type is ADD_DOCUMENT.
    public let suggestedTextTitle: String
    /// Suggested document text if the fix type is ADD_DOCUMENT.
    public let suggestedText: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: EntityId,
        suggestedTextTitle: String,
        suggestedText: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.suggestedTextTitle = suggestedTextTitle
        self.suggestedText = suggestedText
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(EntityId.self, forKey: .id)
        self.suggestedTextTitle = try container.decode(String.self, forKey: .suggestedTextTitle)
        self.suggestedText = try container.decode(String.self, forKey: .suggestedText)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.suggestedTextTitle, forKey: .suggestedTextTitle)
        try container.encode(self.suggestedText, forKey: .suggestedText)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case suggestedTextTitle
        case suggestedText
    }
}