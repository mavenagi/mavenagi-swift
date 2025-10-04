import Foundation

public struct TranslationRequest: Codable, Hashable, Sendable {
    /// The text to translate
    public let text: String
    /// The target language to translate to, in ISO 639-1 code format.
    public let targetLanguage: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        text: String,
        targetLanguage: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.text = text
        self.targetLanguage = targetLanguage
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
        self.targetLanguage = try container.decode(String.self, forKey: .targetLanguage)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.text, forKey: .text)
        try container.encode(self.targetLanguage, forKey: .targetLanguage)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case text
        case targetLanguage
    }
}