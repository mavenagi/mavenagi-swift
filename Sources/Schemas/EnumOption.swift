import Foundation

/// Option for STRING/MULTILINE/NUMBER fields when a finite set is desired
public struct EnumOption: Codable, Hashable, Sendable {
    /// The value of the option
    public let value: String
    /// Display label for the option
    public let label: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        value: String,
        label: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.value = value
        self.label = label
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(String.self, forKey: .value)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.value, forKey: .value)
        try container.encodeIfPresent(self.label, forKey: .label)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case value
        case label
    }
}