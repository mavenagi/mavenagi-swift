import Foundation

public struct ActionEnumOption: Codable, Hashable, Sendable {
    /// Will be shown during form display as the user facing string in a dropdown or radio.
    public let label: String
    /// A valid value for the field.
    public let value: JSONValue
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        label: String,
        value: JSONValue,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.label = label
        self.value = value
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.label = try container.decode(String.self, forKey: .label)
        self.value = try container.decode(JSONValue.self, forKey: .value)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.label, forKey: .label)
        try container.encode(self.value, forKey: .value)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case label
        case value
    }
}