import Foundation

public struct AgentUserTableRequest: Codable, Hashable, Sendable {
    /// Optional filter applied to refine the agent user data before processing.
    public let agentUserFilter: AgentUserFilter?
    /// IANA timezone identifier (e.g., "America/Los_Angeles").
    /// When provided, time-based groupings (e.g., DAY) and date filters are evaluated in this timezone;
    /// otherwise UTC is used.
    public let timezone: String?
    /// Defines the time interval for grouping data. If specified, data is grouped accordingly based on the time they were created.
    ///  Example: If set to "DAY," data will be aggregated by day.
    public let timeGrouping: TimeInterval?
    /// Specifies the metrics to be displayed as columns.
    /// Only the `count` metric is supported for agent user tables, so each table will have a single column definition using `count`.
    public let columnDefinitions: [AgentUserColumnDefinition]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        agentUserFilter: AgentUserFilter? = nil,
        timezone: String? = nil,
        timeGrouping: TimeInterval? = nil,
        columnDefinitions: [AgentUserColumnDefinition],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.agentUserFilter = agentUserFilter
        self.timezone = timezone
        self.timeGrouping = timeGrouping
        self.columnDefinitions = columnDefinitions
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.agentUserFilter = try container.decodeIfPresent(AgentUserFilter.self, forKey: .agentUserFilter)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        self.timeGrouping = try container.decodeIfPresent(TimeInterval.self, forKey: .timeGrouping)
        self.columnDefinitions = try container.decode([AgentUserColumnDefinition].self, forKey: .columnDefinitions)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.agentUserFilter, forKey: .agentUserFilter)
        try container.encodeIfPresent(self.timezone, forKey: .timezone)
        try container.encodeIfPresent(self.timeGrouping, forKey: .timeGrouping)
        try container.encode(self.columnDefinitions, forKey: .columnDefinitions)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case agentUserFilter
        case timezone
        case timeGrouping
        case columnDefinitions
    }
}