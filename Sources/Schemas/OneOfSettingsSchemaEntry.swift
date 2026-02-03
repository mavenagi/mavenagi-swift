import Foundation

public struct OneOfSettingsSchemaEntry: Codable, Hashable, Sendable {
    public let key: String
    public let displayName: String
    public let description: String?
    public let visibility: VisibilityType?
    /// Whether the setting must have a value upon install. Defaults to false.
    public let required: Bool?
    public let unionOptions: SettingsSchemaDiscriminatedUnionOptions
    public let defaultValue: JSONValue?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        key: String,
        displayName: String,
        description: String? = nil,
        visibility: VisibilityType? = nil,
        required: Bool? = nil,
        unionOptions: SettingsSchemaDiscriminatedUnionOptions,
        defaultValue: JSONValue? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.key = key
        self.displayName = displayName
        self.description = description
        self.visibility = visibility
        self.required = required
        self.unionOptions = unionOptions
        self.defaultValue = defaultValue
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decode(String.self, forKey: .key)
        self.displayName = try container.decode(String.self, forKey: .displayName)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.visibility = try container.decodeIfPresent(VisibilityType.self, forKey: .visibility)
        self.required = try container.decodeIfPresent(Bool.self, forKey: .required)
        self.unionOptions = try container.decode(SettingsSchemaDiscriminatedUnionOptions.self, forKey: .unionOptions)
        self.defaultValue = try container.decodeIfPresent(JSONValue.self, forKey: .defaultValue)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.key, forKey: .key)
        try container.encode(self.displayName, forKey: .displayName)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.visibility, forKey: .visibility)
        try container.encodeIfPresent(self.required, forKey: .required)
        try container.encode(self.unionOptions, forKey: .unionOptions)
        try container.encodeIfPresent(self.defaultValue, forKey: .defaultValue)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case key
        case displayName
        case description
        case visibility
        case required
        case unionOptions
        case defaultValue
    }
}