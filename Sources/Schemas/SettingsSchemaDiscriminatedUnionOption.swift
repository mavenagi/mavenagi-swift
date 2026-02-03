import Foundation

public struct SettingsSchemaDiscriminatedUnionOption: Codable, Hashable, Sendable {
    /// The value for this option (used as discriminator value)
    public let value: String
    /// The display name shown in the dropdown
    public let displayName: String
    /// Optional description for this option
    public let description: String?
    /// The schema fields to display when this option is selected. Required fields within these fields are only validated when this option is active.
    public let fields: SettingsSchema
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        value: String,
        displayName: String,
        description: String? = nil,
        fields: SettingsSchema,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.value = value
        self.displayName = displayName
        self.description = description
        self.fields = fields
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(String.self, forKey: .value)
        self.displayName = try container.decode(String.self, forKey: .displayName)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.fields = try container.decode(SettingsSchema.self, forKey: .fields)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.value, forKey: .value)
        try container.encode(self.displayName, forKey: .displayName)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encode(self.fields, forKey: .fields)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case value
        case displayName
        case description
        case fields
    }
}