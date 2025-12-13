import Foundation

public struct CustomerPatchRequest: Codable, Hashable, Sendable {
    /// The App ID of the customer to update. If not provided, the ID of the calling app will be used.
    public let appId: String?
    /// The name of the customer.
    public let name: String?
    /// The description of the customer.
    public let description: String?
    /// Whether or not the customer is in active use.
    /// 
    /// Only active customers will be available for agent interactions.
    public let status: CustomerStatus?
    /// Metadata associated with the customer. If not provided, the existing metadata will be preserved.
    public let metadata: [String: String]?
    /// Set of agent user IDs to assign to this customer. If provided, replaces all existing assignees.
    public let assignees: JSONValue?
    /// Set of agent user IDs who are members of this customer. If provided, replaces all existing members.
    public let members: JSONValue?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        appId: String? = nil,
        name: String? = nil,
        description: String? = nil,
        status: CustomerStatus? = nil,
        metadata: [String: String]? = nil,
        assignees: JSONValue? = nil,
        members: JSONValue? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.appId = appId
        self.name = name
        self.description = description
        self.status = status
        self.metadata = metadata
        self.assignees = assignees
        self.members = members
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.status = try container.decodeIfPresent(CustomerStatus.self, forKey: .status)
        self.metadata = try container.decodeIfPresent([String: String].self, forKey: .metadata)
        self.assignees = try container.decodeIfPresent(JSONValue.self, forKey: .assignees)
        self.members = try container.decodeIfPresent(JSONValue.self, forKey: .members)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.appId, forKey: .appId)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.status, forKey: .status)
        try container.encodeIfPresent(self.metadata, forKey: .metadata)
        try container.encodeIfPresent(self.assignees, forKey: .assignees)
        try container.encodeIfPresent(self.members, forKey: .members)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case appId
        case name
        case description
        case status
        case metadata
        case assignees
        case members
    }
}