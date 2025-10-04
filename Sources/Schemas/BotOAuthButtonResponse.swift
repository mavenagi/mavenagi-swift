import Foundation

/// This response should be rendered as a single button that starts an OAuth authorization flow.
public struct BotOAuthButtonResponse: Codable, Hashable, Sendable {
    /// Text that should be displayed to the user on the button.
    public let buttonName: String
    /// The OAuth authorization URL to open when the button is clicked. Will only be provided on ask responses.
    public let url: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        buttonName: String,
        url: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.buttonName = buttonName
        self.url = url
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.buttonName = try container.decode(String.self, forKey: .buttonName)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.buttonName, forKey: .buttonName)
        try container.encodeIfPresent(self.url, forKey: .url)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case buttonName
        case url
    }
}