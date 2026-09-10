import Foundation

/// A detailed app definition used when rendering an app detail page within the app directory.
/// The instructions, installationInstructions, previewUrl have their templated values substituted with appropriate values.
public struct MarketplaceAppDetail: Codable, Hashable, Sendable {
    /// Guidance shown while installing the app, for example how to obtain the credentials it asks for.
    public let installationInstructions: String?
    /// Guidance shown once the app is installed.
    public let instructions: String?
    /// URL of a preview image or demo for the app's detail page.
    public let previewUrl: String?
    /// Supporting links published by the author, such as documentation or a privacy policy.
    public let links: [Link]
    /// The settings the app accepts. Drives the install form, and describes which values are files
    /// rather than plain values.
    public let settingsSchema: SettingsSchema
    /// Unique, immutable identifier for the app, used as `appId` everywhere in the API.
    public let id: String
    /// Display name shown in the app directory.
    public let name: String
    /// Id of the organization that authored the app, which is not the organization it is installed in.
    public let developerOrganizationId: String
    /// Public profile of the authoring organization, for attribution in the directory.
    public let creator: DeveloperOrganization?
    /// Who can discover the app. PUBLIC is listed for every organization; PRIVATE is limited to the
    /// authoring organization and any organization it has been shared with; IN_DEVELOPMENT is not
    /// yet listed.
    public let visibility: AppVisibility
    /// Full description shown on the app's detail page.
    public let description: String?
    /// One-line summary shown on the app's card in the directory listing.
    public let shortDescription: String?
    /// URL of the app's logo. Presigned and short-lived when the logo is stored by Maven.
    public let logoUrl: String?
    /// Categories the app is filed under in the directory.
    public let categories: [AppCategory]
    /// The kinds of functionality the app provides, such as actions, triggers, or knowledge bases.
    public let capabilities: [AppCapability]
    /// Whether this app is an auto-provisioned agent app created for a specific agent.
    public let isAgentApp: Bool?
    /// Whether this app is currently installed on the agent the request was scoped to.
    public let installed: AppInstalled
    /// The installation's stored configuration, as an object keyed by setting key. Present only
    /// when the app is installed on this agent. The keys mirror the app's `settingsSchema`, and a
    /// key is absent when it has never been set.
    /// 
    /// Values nest the way the schema does: a `section` entry holds an object of its fields, a
    /// `oneOf` entry an object of the selected option's fields alongside its `type` discriminator,
    /// and a `complexarray` entry a list of such objects.
    /// 
    /// Two entry types do not return what is stored:
    /// 
    /// - `image` entries return a short-lived presigned download URL, never the file's bytes.
    /// - `oauth` entries return `accessToken` redacted, with `scopes` and `status` intact, so the
    ///   connection still reads as connected without exposing the token.
    /// 
    /// Entries the app's schema marks as sensitive are redacted: `HIDDEN` becomes `********`, and
    /// `PARTIALLY_VISIBLE` keeps only the last three characters (`sk-live-abc` returns as
    /// `********abc`). Values of three characters or fewer are left alone. OAuth access tokens are
    /// redacted whatever the schema says.
    /// 
    /// Redacted values are safe to send back. Install compares each incoming value against the
    /// stored one and skips it when it is that value's redaction, so this object can be read,
    /// edited and written back whole without stripping anything — an untouched credential keeps
    /// its stored value rather than being overwritten with asterisks.
    public let settings: JSONValue?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        installationInstructions: String? = nil,
        instructions: String? = nil,
        previewUrl: String? = nil,
        links: [Link],
        settingsSchema: SettingsSchema,
        id: String,
        name: String,
        developerOrganizationId: String,
        creator: DeveloperOrganization? = nil,
        visibility: AppVisibility,
        description: String? = nil,
        shortDescription: String? = nil,
        logoUrl: String? = nil,
        categories: [AppCategory],
        capabilities: [AppCapability],
        isAgentApp: Bool? = nil,
        installed: AppInstalled,
        settings: JSONValue? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.installationInstructions = installationInstructions
        self.instructions = instructions
        self.previewUrl = previewUrl
        self.links = links
        self.settingsSchema = settingsSchema
        self.id = id
        self.name = name
        self.developerOrganizationId = developerOrganizationId
        self.creator = creator
        self.visibility = visibility
        self.description = description
        self.shortDescription = shortDescription
        self.logoUrl = logoUrl
        self.categories = categories
        self.capabilities = capabilities
        self.isAgentApp = isAgentApp
        self.installed = installed
        self.settings = settings
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.installationInstructions = try container.decodeIfPresent(String.self, forKey: .installationInstructions)
        self.instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        self.previewUrl = try container.decodeIfPresent(String.self, forKey: .previewUrl)
        self.links = try container.decode([Link].self, forKey: .links)
        self.settingsSchema = try container.decode(SettingsSchema.self, forKey: .settingsSchema)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.developerOrganizationId = try container.decode(String.self, forKey: .developerOrganizationId)
        self.creator = try container.decodeIfPresent(DeveloperOrganization.self, forKey: .creator)
        self.visibility = try container.decode(AppVisibility.self, forKey: .visibility)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.shortDescription = try container.decodeIfPresent(String.self, forKey: .shortDescription)
        self.logoUrl = try container.decodeIfPresent(String.self, forKey: .logoUrl)
        self.categories = try container.decode([AppCategory].self, forKey: .categories)
        self.capabilities = try container.decode([AppCapability].self, forKey: .capabilities)
        self.isAgentApp = try container.decodeIfPresent(Bool.self, forKey: .isAgentApp)
        self.installed = try container.decode(AppInstalled.self, forKey: .installed)
        self.settings = try container.decodeIfPresent(JSONValue.self, forKey: .settings)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.installationInstructions, forKey: .installationInstructions)
        try container.encodeIfPresent(self.instructions, forKey: .instructions)
        try container.encodeIfPresent(self.previewUrl, forKey: .previewUrl)
        try container.encode(self.links, forKey: .links)
        try container.encode(self.settingsSchema, forKey: .settingsSchema)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.developerOrganizationId, forKey: .developerOrganizationId)
        try container.encodeIfPresent(self.creator, forKey: .creator)
        try container.encode(self.visibility, forKey: .visibility)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.shortDescription, forKey: .shortDescription)
        try container.encodeIfPresent(self.logoUrl, forKey: .logoUrl)
        try container.encode(self.categories, forKey: .categories)
        try container.encode(self.capabilities, forKey: .capabilities)
        try container.encodeIfPresent(self.isAgentApp, forKey: .isAgentApp)
        try container.encode(self.installed, forKey: .installed)
        try container.encodeIfPresent(self.settings, forKey: .settings)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case installationInstructions
        case instructions
        case previewUrl
        case links
        case settingsSchema
        case id
        case name
        case developerOrganizationId
        case creator
        case visibility
        case description
        case shortDescription
        case logoUrl
        case categories
        case capabilities
        case isAgentApp
        case installed
        case settings
    }
}