import Foundation

public struct UpdateIntegrationRequest: Codable, Hashable, Sendable {
    public let settingsSchema: SettingsSchema?
    public let githubRepository: Nullable<GithubRepository>?
    public let githubBranch: Nullable<String>?
    public let visibility: AppVisibility?
    public let developerOrganizationId: String?
    public let name: String?
    public let description: Nullable<String>?
    public let shortDescription: Nullable<String>?
    public let installationInstructions: Nullable<String>?
    public let instructions: Nullable<String>?
    public let previewUrl: Nullable<String>?
    public let links: [Link]?
    public let categories: [AppCategory]?
    public let capabilities: [AppCapability]?
    public let preinstalled: Bool?
    public let whitelistedOrganizations: [String]?
    public let requestedPermissions: [String]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        settingsSchema: SettingsSchema? = nil,
        githubRepository: Nullable<GithubRepository>? = nil,
        githubBranch: Nullable<String>? = nil,
        visibility: AppVisibility? = nil,
        developerOrganizationId: String? = nil,
        name: String? = nil,
        description: Nullable<String>? = nil,
        shortDescription: Nullable<String>? = nil,
        installationInstructions: Nullable<String>? = nil,
        instructions: Nullable<String>? = nil,
        previewUrl: Nullable<String>? = nil,
        links: [Link]? = nil,
        categories: [AppCategory]? = nil,
        capabilities: [AppCapability]? = nil,
        preinstalled: Bool? = nil,
        whitelistedOrganizations: [String]? = nil,
        requestedPermissions: [String]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.settingsSchema = settingsSchema
        self.githubRepository = githubRepository
        self.githubBranch = githubBranch
        self.visibility = visibility
        self.developerOrganizationId = developerOrganizationId
        self.name = name
        self.description = description
        self.shortDescription = shortDescription
        self.installationInstructions = installationInstructions
        self.instructions = instructions
        self.previewUrl = previewUrl
        self.links = links
        self.categories = categories
        self.capabilities = capabilities
        self.preinstalled = preinstalled
        self.whitelistedOrganizations = whitelistedOrganizations
        self.requestedPermissions = requestedPermissions
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.settingsSchema = try container.decodeIfPresent(SettingsSchema.self, forKey: .settingsSchema)
        self.githubRepository = try container.decodeNullableIfPresent(GithubRepository.self, forKey: .githubRepository)
        self.githubBranch = try container.decodeNullableIfPresent(String.self, forKey: .githubBranch)
        self.visibility = try container.decodeIfPresent(AppVisibility.self, forKey: .visibility)
        self.developerOrganizationId = try container.decodeIfPresent(String.self, forKey: .developerOrganizationId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.description = try container.decodeNullableIfPresent(String.self, forKey: .description)
        self.shortDescription = try container.decodeNullableIfPresent(String.self, forKey: .shortDescription)
        self.installationInstructions = try container.decodeNullableIfPresent(String.self, forKey: .installationInstructions)
        self.instructions = try container.decodeNullableIfPresent(String.self, forKey: .instructions)
        self.previewUrl = try container.decodeNullableIfPresent(String.self, forKey: .previewUrl)
        self.links = try container.decodeIfPresent([Link].self, forKey: .links)
        self.categories = try container.decodeIfPresent([AppCategory].self, forKey: .categories)
        self.capabilities = try container.decodeIfPresent([AppCapability].self, forKey: .capabilities)
        self.preinstalled = try container.decodeIfPresent(Bool.self, forKey: .preinstalled)
        self.whitelistedOrganizations = try container.decodeIfPresent([String].self, forKey: .whitelistedOrganizations)
        self.requestedPermissions = try container.decodeIfPresent([String].self, forKey: .requestedPermissions)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.settingsSchema, forKey: .settingsSchema)
        try container.encodeNullableIfPresent(self.githubRepository, forKey: .githubRepository)
        try container.encodeNullableIfPresent(self.githubBranch, forKey: .githubBranch)
        try container.encodeIfPresent(self.visibility, forKey: .visibility)
        try container.encodeIfPresent(self.developerOrganizationId, forKey: .developerOrganizationId)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeNullableIfPresent(self.description, forKey: .description)
        try container.encodeNullableIfPresent(self.shortDescription, forKey: .shortDescription)
        try container.encodeNullableIfPresent(self.installationInstructions, forKey: .installationInstructions)
        try container.encodeNullableIfPresent(self.instructions, forKey: .instructions)
        try container.encodeNullableIfPresent(self.previewUrl, forKey: .previewUrl)
        try container.encodeIfPresent(self.links, forKey: .links)
        try container.encodeIfPresent(self.categories, forKey: .categories)
        try container.encodeIfPresent(self.capabilities, forKey: .capabilities)
        try container.encodeIfPresent(self.preinstalled, forKey: .preinstalled)
        try container.encodeIfPresent(self.whitelistedOrganizations, forKey: .whitelistedOrganizations)
        try container.encodeIfPresent(self.requestedPermissions, forKey: .requestedPermissions)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case settingsSchema
        case githubRepository
        case githubBranch
        case visibility
        case developerOrganizationId
        case name
        case description
        case shortDescription
        case installationInstructions
        case instructions
        case previewUrl
        case links
        case categories
        case capabilities
        case preinstalled
        case whitelistedOrganizations
        case requestedPermissions
    }
}