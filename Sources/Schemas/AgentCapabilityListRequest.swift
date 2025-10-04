import Foundation

public struct AgentCapabilityListRequest: Codable, Hashable, Sendable {
    /// Page number to return, defaults to 0
    public let page: Int?
    /// The size of the page to return, defaults to 20
    public let size: Int?
    /// Whether to sort descending, defaults to true
    public let sortDesc: Bool?
    public let capabilityType: AgentCapabilityType?
    public let pinned: Bool?
    public let enabled: Bool?
    public let integrationIds: [String]?
    public let description: Nullable<String>?
    public let userInteractionRequired: Bool?
    /// The field to sort by, defaults to created timestamp
    public let sortId: AgentCapabilityField?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        page: Int? = nil,
        size: Int? = nil,
        sortDesc: Bool? = nil,
        capabilityType: AgentCapabilityType? = nil,
        pinned: Bool? = nil,
        enabled: Bool? = nil,
        integrationIds: [String]? = nil,
        description: Nullable<String>? = nil,
        userInteractionRequired: Bool? = nil,
        sortId: AgentCapabilityField? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.page = page
        self.size = size
        self.sortDesc = sortDesc
        self.capabilityType = capabilityType
        self.pinned = pinned
        self.enabled = enabled
        self.integrationIds = integrationIds
        self.description = description
        self.userInteractionRequired = userInteractionRequired
        self.sortId = sortId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page)
        self.size = try container.decodeIfPresent(Int.self, forKey: .size)
        self.sortDesc = try container.decodeIfPresent(Bool.self, forKey: .sortDesc)
        self.capabilityType = try container.decodeIfPresent(AgentCapabilityType.self, forKey: .capabilityType)
        self.pinned = try container.decodeIfPresent(Bool.self, forKey: .pinned)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.integrationIds = try container.decodeIfPresent([String].self, forKey: .integrationIds)
        self.description = try container.decodeNullableIfPresent(String.self, forKey: .description)
        self.userInteractionRequired = try container.decodeIfPresent(Bool.self, forKey: .userInteractionRequired)
        self.sortId = try container.decodeIfPresent(AgentCapabilityField.self, forKey: .sortId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.page, forKey: .page)
        try container.encodeIfPresent(self.size, forKey: .size)
        try container.encodeIfPresent(self.sortDesc, forKey: .sortDesc)
        try container.encodeIfPresent(self.capabilityType, forKey: .capabilityType)
        try container.encodeIfPresent(self.pinned, forKey: .pinned)
        try container.encodeIfPresent(self.enabled, forKey: .enabled)
        try container.encodeIfPresent(self.integrationIds, forKey: .integrationIds)
        try container.encodeNullableIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.userInteractionRequired, forKey: .userInteractionRequired)
        try container.encodeIfPresent(self.sortId, forKey: .sortId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case page
        case size
        case sortDesc
        case capabilityType
        case pinned
        case enabled
        case integrationIds
        case description
        case userInteractionRequired
        case sortId
    }
}