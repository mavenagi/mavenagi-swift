import Foundation

public struct GenerateMavenSuggestionsRequest: Codable, Hashable, Sendable {
    /// The message ids to generate a suggested response for. One suggestion will be generated for each message id.
    public let conversationMessageIds: [EntityIdBase]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        conversationMessageIds: [EntityIdBase],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.conversationMessageIds = conversationMessageIds
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.conversationMessageIds = try container.decode([EntityIdBase].self, forKey: .conversationMessageIds)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.conversationMessageIds, forKey: .conversationMessageIds)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationMessageIds
    }
}