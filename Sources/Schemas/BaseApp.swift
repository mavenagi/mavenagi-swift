import Foundation

/// The fields every app exposes, whatever the surface it is returned from.
public struct BaseApp: Codable, Hashable, Sendable {
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
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
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
        additionalProperties: [String: JSONValue] = .init()
    ) {
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
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
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
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
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
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
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
    }
}