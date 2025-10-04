import Foundation

public struct AppUserRequest: Codable, Hashable, Sendable {
    /// Used to determine whether two users from different apps are the same
    public let identifiers: JSONValue
    public let data: [String: UserData]
    /// ID that uniquely identifies this app user
    public let userId: EntityIdBase
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        identifiers: JSONValue,
        data: [String: UserData],
        userId: EntityIdBase,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.identifiers = identifiers
        self.data = data
        self.userId = userId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifiers = try container.decode(JSONValue.self, forKey: .identifiers)
        self.data = try container.decode([String: UserData].self, forKey: .data)
        self.userId = try container.decode(EntityIdBase.self, forKey: .userId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.identifiers, forKey: .identifiers)
        try container.encode(self.data, forKey: .data)
        try container.encode(self.userId, forKey: .userId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case identifiers
        case data
        case userId
    }
}