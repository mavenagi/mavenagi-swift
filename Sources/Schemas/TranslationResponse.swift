import Foundation

public struct TranslationResponse: Codable, Hashable, Sendable {
    /// The translated text
    public let translatedText: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        translatedText: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.translatedText = translatedText
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.translatedText = try container.decode(String.self, forKey: .translatedText)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.translatedText, forKey: .translatedText)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case translatedText
    }
}