import Foundation

public enum TimeWindow: Codable, Hashable, Sendable {
    /// A single span between two instants, for one-off dates such as a sale or an outage.
    case absolute(Absolute)
    /// A window that repeats on a calendar, such as weekly business hours.
    case recurring(Recurring)
    /// One span a week that can cross days, such as Friday evening through Monday morning.
    case weekly(Weekly)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .windowType)
        switch discriminant {
        case "absolute":
            self = .absolute(try Absolute(from: decoder))
        case "recurring":
            self = .recurring(try Recurring(from: decoder))
        case "weekly":
            self = .weekly(try Weekly(from: decoder))
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown shape discriminant value: \(discriminant)"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws -> Void {
        switch self {
        case .absolute(let data):
            try data.encode(to: encoder)
        case .recurring(let data):
            try data.encode(to: encoder)
        case .weekly(let data):
            try data.encode(to: encoder)
        }
    }

    /// A single span between two instants, for one-off dates such as a sale or an outage.
    public struct Absolute: Codable, Hashable, Sendable {
        public let windowType: String = "absolute"
        /// The first instant inside the window. Omit to leave the window open at the start.
        public let start: Date?
        /// The first instant after the window. Omit to leave the window open at the end.
        public let end: Date?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            start: Date? = nil,
            end: Date? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.start = start
            self.end = end
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.start = try container.decodeIfPresent(Date.self, forKey: .start)
            self.end = try container.decodeIfPresent(Date.self, forKey: .end)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.windowType, forKey: .windowType)
            try container.encodeIfPresent(self.start, forKey: .start)
            try container.encodeIfPresent(self.end, forKey: .end)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case windowType
            case start
            case end
        }
    }

    /// A window that repeats on a calendar, such as weekly business hours.
    public struct Recurring: Codable, Hashable, Sendable {
        public let windowType: String = "recurring"
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
            try container.encode(self.windowType, forKey: .windowType)
            try container.encode(self.timezone, forKey: .timezone)
            try container.encodeIfPresent(self.days, forKey: .days)
            try container.encodeIfPresent(self.months, forKey: .months)
            try container.encodeIfPresent(self.timeOfDay, forKey: .timeOfDay)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case windowType
            case timezone
            case days
            case months
            case timeOfDay
        }
    }

    /// One span a week that can cross days, such as Friday evening through Monday morning.
    public struct Weekly: Codable, Hashable, Sendable {
        public let windowType: String = "weekly"
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
            try container.encode(self.windowType, forKey: .windowType)
            try container.encode(self.timezone, forKey: .timezone)
            try container.encode(self.start, forKey: .start)
            try container.encode(self.end, forKey: .end)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case windowType
            case timezone
            case start
            case end
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case windowType
    }
}