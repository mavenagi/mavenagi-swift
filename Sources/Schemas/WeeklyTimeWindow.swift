import Foundation

/// A half-open span `[start, end)` that repeats every week on the calendar of one timezone,
/// for a rule that runs across days, such as weekend coverage from Friday 18:00 to Monday 08:00.
/// A `recurring` window cannot say this in one window, because its `timeOfDay` applies to each
/// matching day on its own.
/// 
/// The week runs from Monday to Sunday, and an `end` earlier in the week than `start` wraps past
/// Sunday night, the way a `timeOfDay` end before its start wraps past midnight. `start` and
/// `end` must differ.
/// 
/// Both ends are wall-clock times in `timezone`, so the span follows daylight saving: in a
/// week when the clocks change inside the span, it is up to an hour shorter or longer, and a
/// wall-clock minute that happens twice when the clocks go back is inside the span both times.
public struct WeeklyTimeWindow: Codable, Hashable, Sendable {
    /// The IANA timezone the days and times are read in (e.g. "America/New_York"). Required: the server applies no default timezone. Fixed offsets (e.g. "-08:00") and legacy IDs (e.g. "EST") are accepted, but they do not follow daylight saving.
    public let timezone: String
    /// The first minute inside the span, e.g. Friday at "18:00".
    public let start: WeekTime
    /// The first minute after the span, e.g. Monday at "08:00".
    public let end: WeekTime
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        timezone: String,
        start: WeekTime,
        end: WeekTime,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.timezone = timezone
        self.start = start
        self.end = end
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timezone = try container.decode(String.self, forKey: .timezone)
        self.start = try container.decode(WeekTime.self, forKey: .start)
        self.end = try container.decode(WeekTime.self, forKey: .end)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.timezone, forKey: .timezone)
        try container.encode(self.start, forKey: .start)
        try container.encode(self.end, forKey: .end)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case timezone
        case start
        case end
    }
}