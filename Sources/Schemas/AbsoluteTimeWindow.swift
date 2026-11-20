import Foundation

/// A half-open span `[start, end)` between two instants. Set only `start` for "after", only
/// `end` for "before", or both for "between". At least one is required, and `start` must be
/// before `end` when both are set.
/// 
/// Both ends are instants with an offset, so a client converts a local date to an instant
/// before sending it; matching compares instants and applies no timezone. The server keeps
/// each end's instant but not the offset it was sent with, so each end reads back at
/// `timezone`'s offset on that date, or in UTC without one.
public struct AbsoluteTimeWindow: Codable, Hashable, Sendable {
    /// The IANA timezone the window was written in (e.g. "America/New_York"), kept so an editor can show the ends in it again. It does not change which instants match. Fixed offsets (e.g. "-08:00") and legacy IDs (e.g. "EST") are accepted, but the ends then read back at a fixed offset that ignores daylight saving. Clients can prefill it from the agent's `defaultTimezone`.
    public let timezone: String?
    /// The first instant inside the window. Omit to leave the window open at the start.
    public let start: Date?
    /// The first instant after the window. Omit to leave the window open at the end.
    public let end: Date?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        timezone: String? = nil,
        start: Date? = nil,
        end: Date? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.timezone = timezone
        self.start = start
        self.end = end
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        self.start = try container.decodeIfPresent(Date.self, forKey: .start)
        self.end = try container.decodeIfPresent(Date.self, forKey: .end)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.timezone, forKey: .timezone)
        try container.encodeIfPresent(self.start, forKey: .start)
        try container.encodeIfPresent(self.end, forKey: .end)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case timezone
        case start
        case end
    }
}