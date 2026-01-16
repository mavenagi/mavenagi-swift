import Foundation

public struct ActionUser: Codable, Hashable, Sendable {
    /// A user ID that can be used to store user information. Will only be undefined on legacy surfaces.
    public let userId: EntityIdBase?
    /// The ID of the agent user that the userId is associated with
    public let agentUserId: String?
    /// All known identifiers for the user who is executing the action.
    public let userIdentifiers: [AppUserIdentifier]
    /// Data from all apps
    public let allUserData: [String: [String: String]]
    /// Default data for this user
    public let defaultUserData: [String: String]
    /// All user data for this user, including reverse indexable user data
    public let agentUserData: [String: [UserDataWithReference]]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        userId: EntityIdBase? = nil,
        agentUserId: String? = nil,
        userIdentifiers: [AppUserIdentifier],
        allUserData: [String: [String: String]],
        defaultUserData: [String: String],
        agentUserData: [String: [UserDataWithReference]],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.userId = userId
        self.agentUserId = agentUserId
        self.userIdentifiers = userIdentifiers
        self.allUserData = allUserData
        self.defaultUserData = defaultUserData
        self.agentUserData = agentUserData
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decodeIfPresent(EntityIdBase.self, forKey: .userId)
        self.agentUserId = try container.decodeIfPresent(String.self, forKey: .agentUserId)
        self.userIdentifiers = try container.decode([AppUserIdentifier].self, forKey: .userIdentifiers)
        self.allUserData = try container.decode([String: [String: String]].self, forKey: .allUserData)
        self.defaultUserData = try container.decode([String: String].self, forKey: .defaultUserData)
        self.agentUserData = try container.decode([String: [UserDataWithReference]].self, forKey: .agentUserData)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.agentUserId, forKey: .agentUserId)
        try container.encode(self.userIdentifiers, forKey: .userIdentifiers)
        try container.encode(self.allUserData, forKey: .allUserData)
        try container.encode(self.defaultUserData, forKey: .defaultUserData)
        try container.encode(self.agentUserData, forKey: .agentUserData)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case userId
        case agentUserId
        case userIdentifiers
        case allUserData
        case defaultUserData
        case agentUserData
    }
}