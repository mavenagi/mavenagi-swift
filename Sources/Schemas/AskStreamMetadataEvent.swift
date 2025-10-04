import Foundation

public struct AskStreamMetadataEvent: Codable, Hashable, Sendable {
    public let followupQuestions: [String]
    public let sources: [Source]
    /// The language of the message in ISO 639-1 code format
    public let language: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        followupQuestions: [String],
        sources: [Source],
        language: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.followupQuestions = followupQuestions
        self.sources = sources
        self.language = language
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.followupQuestions = try container.decode([String].self, forKey: .followupQuestions)
        self.sources = try container.decode([Source].self, forKey: .sources)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.followupQuestions, forKey: .followupQuestions)
        try container.encode(self.sources, forKey: .sources)
        try container.encodeIfPresent(self.language, forKey: .language)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case followupQuestions
        case sources
        case language
    }
}