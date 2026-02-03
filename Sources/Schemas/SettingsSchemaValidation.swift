import Foundation

public struct SettingsSchemaValidation: Codable, Hashable, Sendable {
    /// Regular expression pattern for validation
    public let pattern: String
    /// Custom error message shown when validation fails
    public let errorMessage: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        pattern: String,
        errorMessage: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.pattern = pattern
        self.errorMessage = errorMessage
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pattern = try container.decode(String.self, forKey: .pattern)
        self.errorMessage = try container.decode(String.self, forKey: .errorMessage)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.pattern, forKey: .pattern)
        try container.encode(self.errorMessage, forKey: .errorMessage)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case pattern
        case errorMessage
    }
}