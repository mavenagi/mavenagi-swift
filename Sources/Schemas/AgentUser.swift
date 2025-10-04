import Foundation

public struct AgentUser: Codable, Hashable, Sendable {
    /// The ID of the agent user.
    public let id: String
    /// The date and time the agent user was created
    public let createdAt: Date
    /// The date and time the agent user was last updated
    public let updatedAt: Date
    /// All identifiers for the agent user. This is a merged set of identifiers from the app created users.
    public let identifiers: JSONValue
    /// A name for the agent user, if one can be determined.
    /// The value is derived from the user data provided by individual apps - specifically data fields keyed by `name`, `first_name` or `firstName`.
    public let defaultName: String?
    /// App created users that are associated with this agent user.
    /// If two apps create users with the same identifying properties, they will be merged into a single agent user.
    public let users: [AppUserSummary]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: String,
        createdAt: Date,
        updatedAt: Date,
        identifiers: JSONValue,
        defaultName: String? = nil,
        users: [AppUserSummary],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.identifiers = identifiers
        self.defaultName = defaultName
        self.users = users
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.identifiers = try container.decode(JSONValue.self, forKey: .identifiers)
        self.defaultName = try container.decodeIfPresent(String.self, forKey: .defaultName)
        self.users = try container.decode([AppUserSummary].self, forKey: .users)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.updatedAt, forKey: .updatedAt)
        try container.encode(self.identifiers, forKey: .identifiers)
        try container.encodeIfPresent(self.defaultName, forKey: .defaultName)
        try container.encode(self.users, forKey: .users)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case createdAt
        case updatedAt
        case identifiers
        case defaultName
        case users
    }
}