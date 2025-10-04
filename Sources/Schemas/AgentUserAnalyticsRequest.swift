import Foundation

public struct AgentUserAnalyticsRequest: Codable, Hashable, Sendable {
    /// Optional filter applied to refine the agent user data before processing.
    public let agentUserFilter: AgentUserFilter?
    /// IANA timezone identifier (e.g., "America/Los_Angeles").
    /// When provided, time-based groupings (e.g., DAY) and date filters are evaluated in this timezone;
    /// otherwise UTC is used.
    public let timezone: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        agentUserFilter: AgentUserFilter? = nil,
        timezone: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.agentUserFilter = agentUserFilter
        self.timezone = timezone
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.agentUserFilter = try container.decodeIfPresent(AgentUserFilter.self, forKey: .agentUserFilter)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.agentUserFilter, forKey: .agentUserFilter)
        try container.encodeIfPresent(self.timezone, forKey: .timezone)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case agentUserFilter
        case timezone
    }
}