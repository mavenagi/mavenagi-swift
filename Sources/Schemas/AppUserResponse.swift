import Foundation

public struct AppUserResponse: Codable, Hashable, Sendable {
    /// Used to determine whether two users from different apps are the same
    public let identifiers: JSONValue
    public let data: [String: UserData]
    /// ID that uniquely identifies this user
    public let userId: EntityId
    /// The ID of the agent user (merged view) that this app user is associated with
    public let agentUserId: String
    /// Data from all apps
    public let allUserData: [String: [String: String]]
    /// Default data for this user
    public let defaultUserData: [String: String]
    /// All user data for this user, including reverse indexable user data
    public let agentUserData: [String: [UserDataWithReference]]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        identifiers: JSONValue,
        data: [String: UserData],
        userId: EntityId,
        agentUserId: String,
        allUserData: [String: [String: String]],
        defaultUserData: [String: String],
        agentUserData: [String: [UserDataWithReference]],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.identifiers = identifiers
        self.data = data
        self.userId = userId
        self.agentUserId = agentUserId
        self.allUserData = allUserData
        self.defaultUserData = defaultUserData
        self.agentUserData = agentUserData
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifiers = try container.decode(JSONValue.self, forKey: .identifiers)
        self.data = try container.decode([String: UserData].self, forKey: .data)
        self.userId = try container.decode(EntityId.self, forKey: .userId)
        self.agentUserId = try container.decode(String.self, forKey: .agentUserId)
        self.allUserData = try container.decode([String: [String: String]].self, forKey: .allUserData)
        self.defaultUserData = try container.decode([String: String].self, forKey: .defaultUserData)
        self.agentUserData = try container.decode([String: [UserDataWithReference]].self, forKey: .agentUserData)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.identifiers, forKey: .identifiers)
        try container.encode(self.data, forKey: .data)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.agentUserId, forKey: .agentUserId)
        try container.encode(self.allUserData, forKey: .allUserData)
        try container.encode(self.defaultUserData, forKey: .defaultUserData)
        try container.encode(self.agentUserData, forKey: .agentUserData)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case identifiers
        case data
        case userId
        case agentUserId
        case allUserData
        case defaultUserData
        case agentUserData
    }
}