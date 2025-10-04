import Foundation

public struct AskStreamTextEvent: Codable, Hashable, Sendable {
    /// A partial response to the question. All stream text events should be concatenated to form the full response.
    public let contents: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        contents: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.contents = contents
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contents = try container.decode(String.self, forKey: .contents)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.contents, forKey: .contents)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case contents
    }
}