import Foundation

/// Matches documents whose value under `key` equals a value read from the conversation
/// being answered, so one filter follows each conversation instead of naming a fixed value.
/// 
/// When the conversation has no value at `source`, nothing matches. To also keep documents
/// that apply everywhere, combine this with an entry in an `OR` group, for example
/// `state = All`.
public struct MetadataConversationValueFilter: Codable, Hashable, Sendable {
    /// The document metadata key to test, as in `MetadataEntryCondition`.
    public let key: String
    /// Where on the conversation to read the value that documents must equal.
    public let source: ConversationValueSource
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        key: String,
        source: ConversationValueSource,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.key = key
        self.source = source
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decode(String.self, forKey: .key)
        self.source = try container.decode(ConversationValueSource.self, forKey: .source)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.key, forKey: .key)
        try container.encode(self.source, forKey: .source)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case key
        case source
    }
}