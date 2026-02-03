import Foundation

public indirect enum SettingsSchemaEntry: Codable, Hashable, Sendable {
    case array(Array)
    case checkbox(Checkbox)
    case color(Color)
    case complexarray(Complexarray)
    case dropdown(Dropdown)
    case image(Image)
    case multiline(Multiline)
    case number(Number)
    case oauth(Oauth)
    case oneOf(OneOf)
    case section(Section)
    case text(Text)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .type)
        switch discriminant {
        case "array":
            self = .array(try Array(from: decoder))
        case "checkbox":
            self = .checkbox(try Checkbox(from: decoder))
        case "color":
            self = .color(try Color(from: decoder))
        case "complexarray":
            self = .complexarray(try Complexarray(from: decoder))
        case "dropdown":
            self = .dropdown(try Dropdown(from: decoder))
        case "image":
            self = .image(try Image(from: decoder))
        case "multiline":
            self = .multiline(try Multiline(from: decoder))
        case "number":
            self = .number(try Number(from: decoder))
        case "oauth":
            self = .oauth(try Oauth(from: decoder))
        case "oneOf":
            self = .oneOf(try OneOf(from: decoder))
        case "section":
            self = .section(try Section(from: decoder))
        case "text":
            self = .text(try Text(from: decoder))
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown shape discriminant value: \(discriminant)"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws -> Void {
        switch self {
        case .array(let data):
            try data.encode(to: encoder)
        case .checkbox(let data):
            try data.encode(to: encoder)
        case .color(let data):
            try data.encode(to: encoder)
        case .complexarray(let data):
            try data.encode(to: encoder)
        case .dropdown(let data):
            try data.encode(to: encoder)
        case .image(let data):
            try data.encode(to: encoder)
        case .multiline(let data):
            try data.encode(to: encoder)
        case .number(let data):
            try data.encode(to: encoder)
        case .oauth(let data):
            try data.encode(to: encoder)
        case .oneOf(let data):
            try data.encode(to: encoder)
        case .section(let data):
            try data.encode(to: encoder)
        case .text(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Text: Codable, Hashable, Sendable {
        public let type: String = "text"
        public let key: String
        public let displayName: String
        public let description: String?
        public let visibility: VisibilityType?
        /// Whether the setting must have a value upon install. Defaults to false.
        public let required: Bool?
        public let defaultValue: String?
        public let validation: SettingsSchemaValidation?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            displayName: String,
            description: String? = nil,
            visibility: VisibilityType? = nil,
            required: Bool? = nil,
            defaultValue: String? = nil,
            validation: SettingsSchemaValidation? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.displayName = displayName
            self.description = description
            self.visibility = visibility
            self.required = required
            self.defaultValue = defaultValue
            self.validation = validation
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.key = try container.decode(String.self, forKey: .key)
            self.displayName = try container.decode(String.self, forKey: .displayName)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.visibility = try container.decodeIfPresent(VisibilityType.self, forKey: .visibility)
            self.required = try container.decodeIfPresent(Bool.self, forKey: .required)
            self.defaultValue = try container.decodeIfPresent(String.self, forKey: .defaultValue)
            self.validation = try container.decodeIfPresent(SettingsSchemaValidation.self, forKey: .validation)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.key, forKey: .key)
            try container.encode(self.displayName, forKey: .displayName)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.visibility, forKey: .visibility)
            try container.encodeIfPresent(self.required, forKey: .required)
            try container.encodeIfPresent(self.defaultValue, forKey: .defaultValue)
            try container.encodeIfPresent(self.validation, forKey: .validation)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case key
            case displayName
            case description
            case visibility
            case required
            case defaultValue
            case validation
        }
    }

    public struct Multiline: Codable, Hashable, Sendable {
        public let type: String = "multiline"
        public let key: String
        public let displayName: String
        public let description: String?
        public let visibility: VisibilityType?
        /// Whether the setting must have a value upon install. Defaults to false.
        public let required: Bool?
        public let defaultValue: String?
        public let validation: SettingsSchemaValidation?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            displayName: String,
            description: String? = nil,
            visibility: VisibilityType? = nil,
            required: Bool? = nil,
            defaultValue: String? = nil,
            validation: SettingsSchemaValidation? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.displayName = displayName
            self.description = description
            self.visibility = visibility
            self.required = required
            self.defaultValue = defaultValue
            self.validation = validation
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.key = try container.decode(String.self, forKey: .key)
            self.displayName = try container.decode(String.self, forKey: .displayName)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.visibility = try container.decodeIfPresent(VisibilityType.self, forKey: .visibility)
            self.required = try container.decodeIfPresent(Bool.self, forKey: .required)
            self.defaultValue = try container.decodeIfPresent(String.self, forKey: .defaultValue)
            self.validation = try container.decodeIfPresent(SettingsSchemaValidation.self, forKey: .validation)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.key, forKey: .key)
            try container.encode(self.displayName, forKey: .displayName)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.visibility, forKey: .visibility)
            try container.encodeIfPresent(self.required, forKey: .required)
            try container.encodeIfPresent(self.defaultValue, forKey: .defaultValue)
            try container.encodeIfPresent(self.validation, forKey: .validation)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case key
            case displayName
            case description
            case visibility
            case required
            case defaultValue
            case validation
        }
    }

    public struct Array: Codable, Hashable, Sendable {
        public let type: String = "array"
        public let key: String
        public let displayName: String
        public let description: String?
        public let visibility: VisibilityType?
        /// Whether the setting must have a value upon install. Defaults to false.
        public let required: Bool?
        public let defaultValue: [String]?
        public let validation: SettingsSchemaValidation?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            displayName: String,
            description: String? = nil,
            visibility: VisibilityType? = nil,
            required: Bool? = nil,
            defaultValue: [String]? = nil,
            validation: SettingsSchemaValidation? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.displayName = displayName
            self.description = description
            self.visibility = visibility
            self.required = required
            self.defaultValue = defaultValue
            self.validation = validation
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.key = try container.decode(String.self, forKey: .key)
            self.displayName = try container.decode(String.self, forKey: .displayName)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.visibility = try container.decodeIfPresent(VisibilityType.self, forKey: .visibility)
            self.required = try container.decodeIfPresent(Bool.self, forKey: .required)
            self.defaultValue = try container.decodeIfPresent([String].self, forKey: .defaultValue)
            self.validation = try container.decodeIfPresent(SettingsSchemaValidation.self, forKey: .validation)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.key, forKey: .key)
            try container.encode(self.displayName, forKey: .displayName)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.visibility, forKey: .visibility)
            try container.encodeIfPresent(self.required, forKey: .required)
            try container.encodeIfPresent(self.defaultValue, forKey: .defaultValue)
            try container.encodeIfPresent(self.validation, forKey: .validation)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case key
            case displayName
            case description
            case visibility
            case required
            case defaultValue
            case validation
        }
    }

    public struct Complexarray: Codable, Hashable, Sendable {
        public let type: String = "complexarray"
        public let key: String
        public let displayName: String
        public let description: String?
        public let visibility: VisibilityType?
        /// Whether the setting must have a value upon install. Defaults to false.
        public let required: Bool?
        public let fields: SettingsSchema?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            displayName: String,
            description: String? = nil,
            visibility: VisibilityType? = nil,
            required: Bool? = nil,
            fields: SettingsSchema? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.displayName = displayName
            self.description = description
            self.visibility = visibility
            self.required = required
            self.fields = fields
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.key = try container.decode(String.self, forKey: .key)
            self.displayName = try container.decode(String.self, forKey: .displayName)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.visibility = try container.decodeIfPresent(VisibilityType.self, forKey: .visibility)
            self.required = try container.decodeIfPresent(Bool.self, forKey: .required)
            self.fields = try container.decodeIfPresent(SettingsSchema.self, forKey: .fields)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.key, forKey: .key)
            try container.encode(self.displayName, forKey: .displayName)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.visibility, forKey: .visibility)
            try container.encodeIfPresent(self.required, forKey: .required)
            try container.encodeIfPresent(self.fields, forKey: .fields)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case key
            case displayName
            case description
            case visibility
            case required
            case fields
        }
    }

    public struct Color: Codable, Hashable, Sendable {
        public let type: String = "color"
        public let key: String
        public let displayName: String
        public let description: String?
        public let visibility: VisibilityType?
        /// Whether the setting must have a value upon install. Defaults to false.
        public let required: Bool?
        public let defaultValue: String?
        public let validation: SettingsSchemaValidation?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            displayName: String,
            description: String? = nil,
            visibility: VisibilityType? = nil,
            required: Bool? = nil,
            defaultValue: String? = nil,
            validation: SettingsSchemaValidation? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.displayName = displayName
            self.description = description
            self.visibility = visibility
            self.required = required
            self.defaultValue = defaultValue
            self.validation = validation
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.key = try container.decode(String.self, forKey: .key)
            self.displayName = try container.decode(String.self, forKey: .displayName)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.visibility = try container.decodeIfPresent(VisibilityType.self, forKey: .visibility)
            self.required = try container.decodeIfPresent(Bool.self, forKey: .required)
            self.defaultValue = try container.decodeIfPresent(String.self, forKey: .defaultValue)
            self.validation = try container.decodeIfPresent(SettingsSchemaValidation.self, forKey: .validation)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.key, forKey: .key)
            try container.encode(self.displayName, forKey: .displayName)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.visibility, forKey: .visibility)
            try container.encodeIfPresent(self.required, forKey: .required)
            try container.encodeIfPresent(self.defaultValue, forKey: .defaultValue)
            try container.encodeIfPresent(self.validation, forKey: .validation)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case key
            case displayName
            case description
            case visibility
            case required
            case defaultValue
            case validation
        }
    }

    public struct Image: Codable, Hashable, Sendable {
        public let type: String = "image"
        public let key: String
        public let displayName: String
        public let description: String?
        public let visibility: VisibilityType?
        /// Whether the setting must have a value upon install. Defaults to false.
        public let required: Bool?
        public let defaultValue: String?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            displayName: String,
            description: String? = nil,
            visibility: VisibilityType? = nil,
            required: Bool? = nil,
            defaultValue: String? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.displayName = displayName
            self.description = description
            self.visibility = visibility
            self.required = required
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
            self.defaultValue = try container.decodeIfPresent(String.self, forKey: .defaultValue)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.key, forKey: .key)
            try container.encode(self.displayName, forKey: .displayName)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.visibility, forKey: .visibility)
            try container.encodeIfPresent(self.required, forKey: .required)
            try container.encodeIfPresent(self.defaultValue, forKey: .defaultValue)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case key
            case displayName
            case description
            case visibility
            case required
            case defaultValue
        }
    }

    public struct Checkbox: Codable, Hashable, Sendable {
        public let type: String = "checkbox"
        public let key: String
        public let displayName: String
        public let description: String?
        public let visibility: VisibilityType?
        /// Whether the setting must have a value upon install. Defaults to false.
        public let required: Bool?
        public let defaultValue: Bool?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            displayName: String,
            description: String? = nil,
            visibility: VisibilityType? = nil,
            required: Bool? = nil,
            defaultValue: Bool? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.displayName = displayName
            self.description = description
            self.visibility = visibility
            self.required = required
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
            self.defaultValue = try container.decodeIfPresent(Bool.self, forKey: .defaultValue)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.key, forKey: .key)
            try container.encode(self.displayName, forKey: .displayName)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.visibility, forKey: .visibility)
            try container.encodeIfPresent(self.required, forKey: .required)
            try container.encodeIfPresent(self.defaultValue, forKey: .defaultValue)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case key
            case displayName
            case description
            case visibility
            case required
            case defaultValue
        }
    }

    public struct Dropdown: Codable, Hashable, Sendable {
        public let type: String = "dropdown"
        public let key: String
        public let displayName: String
        public let description: String?
        public let visibility: VisibilityType?
        /// Whether the setting must have a value upon install. Defaults to false.
        public let required: Bool?
        public let dropdownOptions: [String]
        public let defaultValue: String?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            displayName: String,
            description: String? = nil,
            visibility: VisibilityType? = nil,
            required: Bool? = nil,
            dropdownOptions: [String],
            defaultValue: String? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.displayName = displayName
            self.description = description
            self.visibility = visibility
            self.required = required
            self.dropdownOptions = dropdownOptions
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
            self.dropdownOptions = try container.decode([String].self, forKey: .dropdownOptions)
            self.defaultValue = try container.decodeIfPresent(String.self, forKey: .defaultValue)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.key, forKey: .key)
            try container.encode(self.displayName, forKey: .displayName)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.visibility, forKey: .visibility)
            try container.encodeIfPresent(self.required, forKey: .required)
            try container.encode(self.dropdownOptions, forKey: .dropdownOptions)
            try container.encodeIfPresent(self.defaultValue, forKey: .defaultValue)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case key
            case displayName
            case description
            case visibility
            case required
            case dropdownOptions
            case defaultValue
        }
    }

    public struct Section: Codable, Hashable, Sendable {
        public let type: String = "section"
        public let key: String
        public let displayName: String
        public let description: String?
        public let visibility: VisibilityType?
        /// Whether the setting must have a value upon install. Defaults to false.
        public let required: Bool?
        public let fields: SettingsSchema?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            displayName: String,
            description: String? = nil,
            visibility: VisibilityType? = nil,
            required: Bool? = nil,
            fields: SettingsSchema? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.displayName = displayName
            self.description = description
            self.visibility = visibility
            self.required = required
            self.fields = fields
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.key = try container.decode(String.self, forKey: .key)
            self.displayName = try container.decode(String.self, forKey: .displayName)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.visibility = try container.decodeIfPresent(VisibilityType.self, forKey: .visibility)
            self.required = try container.decodeIfPresent(Bool.self, forKey: .required)
            self.fields = try container.decodeIfPresent(SettingsSchema.self, forKey: .fields)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.key, forKey: .key)
            try container.encode(self.displayName, forKey: .displayName)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.visibility, forKey: .visibility)
            try container.encodeIfPresent(self.required, forKey: .required)
            try container.encodeIfPresent(self.fields, forKey: .fields)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case key
            case displayName
            case description
            case visibility
            case required
            case fields
        }
    }

    public struct Oauth: Codable, Hashable, Sendable {
        public let type: String = "oauth"
        public let key: String
        public let displayName: String
        public let description: String?
        public let visibility: VisibilityType?
        /// Whether the setting must have a value upon install. Defaults to false.
        public let required: Bool?
        /// The scopes to request from the OAuth provider.
        public let oauthScopes: [String]
        /// Optional labels for customizing scope display names.
        public let scopeLabels: [JSONValue]?
        public let oauthRedirectUri: String?
        public let oauthClientId: String?
        public let oauthAuthorizationUrl: String?
        public let oauthClientSecret: String?
        public let oauthTokenUrl: String?
        /// The authentication method for OAuth token requests.
        public let oauthAuthenticationMethod: OAuthAuthenticationMethod?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            displayName: String,
            description: String? = nil,
            visibility: VisibilityType? = nil,
            required: Bool? = nil,
            oauthScopes: [String],
            scopeLabels: [JSONValue]? = nil,
            oauthRedirectUri: String? = nil,
            oauthClientId: String? = nil,
            oauthAuthorizationUrl: String? = nil,
            oauthClientSecret: String? = nil,
            oauthTokenUrl: String? = nil,
            oauthAuthenticationMethod: OAuthAuthenticationMethod? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.displayName = displayName
            self.description = description
            self.visibility = visibility
            self.required = required
            self.oauthScopes = oauthScopes
            self.scopeLabels = scopeLabels
            self.oauthRedirectUri = oauthRedirectUri
            self.oauthClientId = oauthClientId
            self.oauthAuthorizationUrl = oauthAuthorizationUrl
            self.oauthClientSecret = oauthClientSecret
            self.oauthTokenUrl = oauthTokenUrl
            self.oauthAuthenticationMethod = oauthAuthenticationMethod
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.key = try container.decode(String.self, forKey: .key)
            self.displayName = try container.decode(String.self, forKey: .displayName)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.visibility = try container.decodeIfPresent(VisibilityType.self, forKey: .visibility)
            self.required = try container.decodeIfPresent(Bool.self, forKey: .required)
            self.oauthScopes = try container.decode([String].self, forKey: .oauthScopes)
            self.scopeLabels = try container.decodeIfPresent([JSONValue].self, forKey: .scopeLabels)
            self.oauthRedirectUri = try container.decodeIfPresent(String.self, forKey: .oauthRedirectUri)
            self.oauthClientId = try container.decodeIfPresent(String.self, forKey: .oauthClientId)
            self.oauthAuthorizationUrl = try container.decodeIfPresent(String.self, forKey: .oauthAuthorizationUrl)
            self.oauthClientSecret = try container.decodeIfPresent(String.self, forKey: .oauthClientSecret)
            self.oauthTokenUrl = try container.decodeIfPresent(String.self, forKey: .oauthTokenUrl)
            self.oauthAuthenticationMethod = try container.decodeIfPresent(OAuthAuthenticationMethod.self, forKey: .oauthAuthenticationMethod)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.key, forKey: .key)
            try container.encode(self.displayName, forKey: .displayName)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.visibility, forKey: .visibility)
            try container.encodeIfPresent(self.required, forKey: .required)
            try container.encode(self.oauthScopes, forKey: .oauthScopes)
            try container.encodeIfPresent(self.scopeLabels, forKey: .scopeLabels)
            try container.encodeIfPresent(self.oauthRedirectUri, forKey: .oauthRedirectUri)
            try container.encodeIfPresent(self.oauthClientId, forKey: .oauthClientId)
            try container.encodeIfPresent(self.oauthAuthorizationUrl, forKey: .oauthAuthorizationUrl)
            try container.encodeIfPresent(self.oauthClientSecret, forKey: .oauthClientSecret)
            try container.encodeIfPresent(self.oauthTokenUrl, forKey: .oauthTokenUrl)
            try container.encodeIfPresent(self.oauthAuthenticationMethod, forKey: .oauthAuthenticationMethod)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case key
            case displayName
            case description
            case visibility
            case required
            case oauthScopes
            case scopeLabels
            case oauthRedirectUri
            case oauthClientId
            case oauthAuthorizationUrl
            case oauthClientSecret
            case oauthTokenUrl
            case oauthAuthenticationMethod
        }
    }

    public struct Number: Codable, Hashable, Sendable {
        public let type: String = "number"
        public let key: String
        public let displayName: String
        public let description: String?
        public let visibility: VisibilityType?
        /// Whether the setting must have a value upon install. Defaults to false.
        public let required: Bool?
        public let defaultValue: Double?
        public let validation: SettingsSchemaValidation?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            displayName: String,
            description: String? = nil,
            visibility: VisibilityType? = nil,
            required: Bool? = nil,
            defaultValue: Double? = nil,
            validation: SettingsSchemaValidation? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.displayName = displayName
            self.description = description
            self.visibility = visibility
            self.required = required
            self.defaultValue = defaultValue
            self.validation = validation
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.key = try container.decode(String.self, forKey: .key)
            self.displayName = try container.decode(String.self, forKey: .displayName)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.visibility = try container.decodeIfPresent(VisibilityType.self, forKey: .visibility)
            self.required = try container.decodeIfPresent(Bool.self, forKey: .required)
            self.defaultValue = try container.decodeIfPresent(Double.self, forKey: .defaultValue)
            self.validation = try container.decodeIfPresent(SettingsSchemaValidation.self, forKey: .validation)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.key, forKey: .key)
            try container.encode(self.displayName, forKey: .displayName)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.visibility, forKey: .visibility)
            try container.encodeIfPresent(self.required, forKey: .required)
            try container.encodeIfPresent(self.defaultValue, forKey: .defaultValue)
            try container.encodeIfPresent(self.validation, forKey: .validation)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case key
            case displayName
            case description
            case visibility
            case required
            case defaultValue
            case validation
        }
    }

    public struct OneOf: Codable, Hashable, Sendable {
        public let type: String = "oneOf"
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
            try container.encode(self.type, forKey: .type)
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
            case type
            case key
            case displayName
            case description
            case visibility
            case required
            case unionOptions
            case defaultValue
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}