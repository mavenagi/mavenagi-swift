import Foundation

public struct CustomerResponse: Codable, Hashable, Sendable {
    public let name: String
    public let description: String?
    public let metadata: [String: String]
    /// Whether or not the customer is in active use.
    /// 
    /// Only active customers will be available for agent interactions.
    public let status: CustomerStatus
    /// ID that uniquely identifies this customer
    public let customerId: EntityId
    /// Set of agent user IDs assigned to this customer
    public let assignees: JSONValue
    /// Set of agent user IDs who are members of this customer
    public let members: JSONValue
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        description: String? = nil,
        metadata: [String: String],
        status: CustomerStatus,
        customerId: EntityId,
        assignees: JSONValue,
        members: JSONValue,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.description = description
        self.metadata = metadata
        self.status = status
        self.customerId = customerId
        self.assignees = assignees
        self.members = members
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.metadata = try container.decode([String: String].self, forKey: .metadata)
        self.status = try container.decode(CustomerStatus.self, forKey: .status)
        self.customerId = try container.decode(EntityId.self, forKey: .customerId)
        self.assignees = try container.decode(JSONValue.self, forKey: .assignees)
        self.members = try container.decode(JSONValue.self, forKey: .members)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encode(self.metadata, forKey: .metadata)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.customerId, forKey: .customerId)
        try container.encode(self.assignees, forKey: .assignees)
        try container.encode(self.members, forKey: .members)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case description
        case metadata
        case status
        case customerId
        case assignees
        case members
    }
}