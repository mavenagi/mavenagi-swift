import Foundation

/// One allowed choice for a field whose value should come from a finite set. Use with
/// MULTI_SELECT to constrain a list of choices, or with STRING/MULTILINE/NUMBER to make
/// the field a single select.
public struct EnumOption: Codable, Hashable, Sendable {
    /// The value of the option
    public let value: String
    /// Display label for the option. Shown in Agent Designer as "Option Name".
    public let label: String?
    /// Instructions that tell the LLM when to pick this option. Up to 1200 characters. On a
    /// patch, an option sent without a description has its description cleared.
    public let description: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        value: String,
        label: String? = nil,
        description: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.value = value
        self.label = label
        self.description = description
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(String.self, forKey: .value)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.value, forKey: .value)
        try container.encodeIfPresent(self.label, forKey: .label)
        try container.encodeIfPresent(self.description, forKey: .description)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case value
        case label
        case description
    }
}