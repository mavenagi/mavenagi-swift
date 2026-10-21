import Foundation

public struct AppUserRequest: Codable, Hashable, Sendable {
    /// Used to determine whether two users from different apps are the same
    public let identifiers: JSONValue
    public let data: [String: UserData]
    /// ID that uniquely identifies this app user
    public let userId: EntityIdBase
    /// The execution mode the user lives in. Defaults to `LIVE` for a new user, and to the existing
    /// user's execution mode on update; an update can't move a user to a different one.
    /// 
    /// A `SIMULATION` user is only linked to other `SIMULATION` users, is excluded from user search
    /// unless `simulationFilter` asks for it, and may only talk in simulation conversations. A `LIVE`
    /// user can't talk in a simulation conversation either, so give each simulation its own user ids
    /// rather than reusing live ones.
    /// Creating one needs the same permission as creating a simulation conversation.
    public let executionMode: ExecutionMode?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        identifiers: JSONValue,
        data: [String: UserData],
        userId: EntityIdBase,
        executionMode: ExecutionMode? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.identifiers = identifiers
        self.data = data
        self.userId = userId
        self.executionMode = executionMode
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifiers = try container.decode(JSONValue.self, forKey: .identifiers)
        self.data = try container.decode([String: UserData].self, forKey: .data)
        self.userId = try container.decode(EntityIdBase.self, forKey: .userId)
        self.executionMode = try container.decodeIfPresent(ExecutionMode.self, forKey: .executionMode)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.identifiers, forKey: .identifiers)
        try container.encode(self.data, forKey: .data)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.executionMode, forKey: .executionMode)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case identifiers
        case data
        case userId
        case executionMode
    }
}