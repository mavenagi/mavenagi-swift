import Foundation

public struct CustomerFilter: Codable, Hashable, Sendable {
    /// The search query to apply to the customers' name and description.
    public let search: String?
    /// The statuses to filter the customers by.
    public let statuses: [CustomerStatus]?
    /// Filter customers by assignee agent user IDs. Returns customers that have any of the specified assignees.
    public let assignees: [String]?
    /// Filter customers by member agent user IDs. Returns customers that have any of the specified members.
    public let members: [String]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        search: String? = nil,
        statuses: [CustomerStatus]? = nil,
        assignees: [String]? = nil,
        members: [String]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.search = search
        self.statuses = statuses
        self.assignees = assignees
        self.members = members
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.search = try container.decodeIfPresent(String.self, forKey: .search)
        self.statuses = try container.decodeIfPresent([CustomerStatus].self, forKey: .statuses)
        self.assignees = try container.decodeIfPresent([String].self, forKey: .assignees)
        self.members = try container.decodeIfPresent([String].self, forKey: .members)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.search, forKey: .search)
        try container.encodeIfPresent(self.statuses, forKey: .statuses)
        try container.encodeIfPresent(self.assignees, forKey: .assignees)
        try container.encodeIfPresent(self.members, forKey: .members)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case search
        case statuses
        case assignees
        case members
    }
}