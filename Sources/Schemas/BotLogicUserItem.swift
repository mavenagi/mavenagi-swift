import Foundation

public struct BotLogicUserItem: Codable, Hashable, Sendable {
    public let userData: [String: String]
    /// The user's name, when one can be determined from their user data. Absent otherwise — how a name is derived may broaden over time, so treat this as a display convenience rather than an identifier.
    public let displayName: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        userData: [String: String],
        displayName: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.userData = userData
        self.displayName = displayName
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userData = try container.decode([String: String].self, forKey: .userData)
        self.displayName = try container.decodeIfPresent(String.self, forKey: .displayName)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.userData, forKey: .userData)
        try container.encodeIfPresent(self.displayName, forKey: .displayName)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case userData
        case displayName
    }
}