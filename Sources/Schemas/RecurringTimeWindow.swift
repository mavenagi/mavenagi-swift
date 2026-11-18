import Foundation

/// A window that repeats on the calendar of one timezone.
/// 
/// Every field that is set must match, and an unset field matches anything, so a window with
/// only `months: [FEBRUARY]` is all of February and one with only `timeOfDay` is those hours
/// every day. Values inside a set match if any of them does.
/// 
/// When `timeOfDay` wraps past midnight, `days` and `months` apply to the day the window
/// opens: Fridays with 22:00–02:00 runs from Friday night into early Saturday.
public struct RecurringTimeWindow: Codable, Hashable, Sendable {
    /// The IANA timezone the calendar fields are read in (e.g. "America/New_York"). Required because business hours belong to the business, not to the end user, and a rule written against a fixed offset drifts by an hour at every daylight-saving change. Fixed offsets (e.g. "-08:00") and legacy IDs (e.g. "EST") are accepted, but they do not follow daylight saving. Clients can prefill it from the agent's `defaultTimezone`.
    public let timezone: String
    /// Which days the window covers: days of the week, dates of the month, numbered weekdays of the month, or one range of dates every year. Omit to cover every day.
    public let days: DaySelector?
    /// The months the window covers. Omit to cover every month. Not allowed with `yearlyDates` days, which name their own months.
    public let months: JSONValue?
    /// The hours the window covers on each matching day. Omit to cover the whole day.
    public let timeOfDay: TimeOfDayRange?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        timezone: String,
        days: DaySelector? = nil,
        months: JSONValue? = nil,
        timeOfDay: TimeOfDayRange? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.timezone = timezone
        self.days = days
        self.months = months
        self.timeOfDay = timeOfDay
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timezone = try container.decode(String.self, forKey: .timezone)
        self.days = try container.decodeIfPresent(DaySelector.self, forKey: .days)
        self.months = try container.decodeIfPresent(JSONValue.self, forKey: .months)
        self.timeOfDay = try container.decodeIfPresent(TimeOfDayRange.self, forKey: .timeOfDay)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.timezone, forKey: .timezone)
        try container.encodeIfPresent(self.days, forKey: .days)
        try container.encodeIfPresent(self.months, forKey: .months)
        try container.encodeIfPresent(self.timeOfDay, forKey: .timeOfDay)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case timezone
        case days
        case months
        case timeOfDay
    }
}