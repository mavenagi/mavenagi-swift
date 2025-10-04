import Foundation

public struct ConversationAnalyticsRequest: Codable, Hashable, Sendable {
    /// Optional filter applied to refine the conversation data before processing.
    public let conversationFilter: ConversationFilter?
    /// IANA timezone identifier (e.g., "America/Los_Angeles").
    /// When provided, time-based groupings (e.g., DAY) and date filters are evaluated in this timezone;
    /// otherwise UTC is used.
    public let timezone: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        conversationFilter: ConversationFilter? = nil,
        timezone: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.conversationFilter = conversationFilter
        self.timezone = timezone
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.conversationFilter = try container.decodeIfPresent(ConversationFilter.self, forKey: .conversationFilter)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.conversationFilter, forKey: .conversationFilter)
        try container.encodeIfPresent(self.timezone, forKey: .timezone)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationFilter
        case timezone
    }
}