import Foundation

/// Who made a change, as recorded when it was made.
public struct ChangeAuthor: Codable, Hashable, Sendable {
    /// The mavenUser ID of the person the change was made for, the same as `MavenUser.id`: one ID
    /// for the person in every organization. The mavenUsers API gives their current name. It answers
    /// 404 for someone the caller can no longer read, such as a person who left the organization, so
    /// fall back to `name` then. Absent when no person was recorded: an app that acted for no one, a
    /// change made with no signed-in caller, and older changes.
    public let mavenUserId: LeveledEntityId?
    /// Who made the change, as their name read at the time; it does not change if they rename later. When an app acted for a person signed in to Maven, their name (absent if they have no name on record). When an app acted for no person, the app's ID. Changes recorded before people were tracked usually name the app. A change made with no signed-in caller, such as background setup work, reads "Anonymous", and some older changes name a dashboard user.
    public let name: String?
    /// The ID of the app that made the change. Absent when no app made it, such as a change with no signed-in caller, and for older changes where no app was recorded.
    public let actingAppId: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        mavenUserId: LeveledEntityId? = nil,
        name: String? = nil,
        actingAppId: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.mavenUserId = mavenUserId
        self.name = name
        self.actingAppId = actingAppId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mavenUserId = try container.decodeIfPresent(LeveledEntityId.self, forKey: .mavenUserId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.actingAppId = try container.decodeIfPresent(String.self, forKey: .actingAppId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.mavenUserId, forKey: .mavenUserId)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.actingAppId, forKey: .actingAppId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case mavenUserId
        case name
        case actingAppId
    }
}