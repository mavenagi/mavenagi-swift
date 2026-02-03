import Foundation

public struct OAuthSettingsSchemaEntry: Codable, Hashable, Sendable {
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