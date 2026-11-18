import Foundation

public struct UserDataWithReference: Codable, Hashable, Sendable {
    /// The value of the user metadata
    public let value: String
    /// Who sees the value.
    /// 
    /// - `VISIBLE`: the agent (the LLM) is given the value.
    /// - `PARTIALLY_VISIBLE`: the agent is not given the value. Agent user responses mask all
    ///   but its last 3 characters.
    /// - `HIDDEN`: the agent is not given the value. Agent user responses show it as `********`.
    /// 
    /// Visibility only controls what the agent is given and how agent user responses
    /// (`visibleData`) mask the value. It is not encryption or access control. Every value,
    /// whatever its visibility, is returned in full by `GET /users/{userId}` and
    /// `PUT /users` (in `data`, `allUserData` and `agentUserData`) and is passed to the
    /// actions and functions of every app that run for the user.
    public let visibility: VisibilityType
    /// Reverse index containing appId and referenceId data that identifies this app user
    public let userId: EntityIdFilter
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        value: String,
        visibility: VisibilityType,
        userId: EntityIdFilter,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.value = value
        self.visibility = visibility
        self.userId = userId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(String.self, forKey: .value)
        self.visibility = try container.decode(VisibilityType.self, forKey: .visibility)
        self.userId = try container.decode(EntityIdFilter.self, forKey: .userId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.value, forKey: .value)
        try container.encode(self.visibility, forKey: .visibility)
        try container.encode(self.userId, forKey: .userId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case value
        case visibility
        case userId
    }
}