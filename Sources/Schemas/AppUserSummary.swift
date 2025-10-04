import Foundation

public struct AppUserSummary: Codable, Hashable, Sendable {
    /// App provided user ID.
    public let userId: EntityId
    /// App provided identifiers for the user.
    public let identifiers: JSONValue
    /// App provided data masked according to the data's visibility type. `HIDDEN` or `PARTIALLY_VISIBLE` data values will be not be fully returned.
    public let visibleData: [String: String]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        userId: EntityId,
        identifiers: JSONValue,
        visibleData: [String: String],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.userId = userId
        self.identifiers = identifiers
        self.visibleData = visibleData
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(EntityId.self, forKey: .userId)
        self.identifiers = try container.decode(JSONValue.self, forKey: .identifiers)
        self.visibleData = try container.decode([String: String].self, forKey: .visibleData)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.identifiers, forKey: .identifiers)
        try container.encode(self.visibleData, forKey: .visibleData)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case userId
        case identifiers
        case visibleData
    }
}