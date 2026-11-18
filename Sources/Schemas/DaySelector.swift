import Foundation

/// Which days a recurring window covers. Each member names one way of picking days, so a
/// selector means exactly what its type says. For a window that covers days picked two ways
/// ("the 15th, or the third Monday"), OR two preconditions in a `PreconditionGroup`.
public enum DaySelector: Codable, Hashable, Sendable {
    /// Fixed dates of the month, such as the 1st, the 15th, or the last day.
    case dayOfMonth(DayOfMonth)
    /// Numbered occurrences within the month, such as the third Monday or the last weekday.
    case nthWeekday(NthWeekday)
    /// Every occurrence of the listed days of the week.
    case weekdays(Weekdays)
    /// One run of dates every year, such as December 24 through January 2.
    case yearlyDates(YearlyDates)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .dayType)
        switch discriminant {
        case "dayOfMonth":
            self = .dayOfMonth(try DayOfMonth(from: decoder))
        case "nthWeekday":
            self = .nthWeekday(try NthWeekday(from: decoder))
        case "weekdays":
            self = .weekdays(try Weekdays(from: decoder))
        case "yearlyDates":
            self = .yearlyDates(try YearlyDates(from: decoder))
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
        case .dayOfMonth(let data):
            try data.encode(to: encoder)
        case .nthWeekday(let data):
            try data.encode(to: encoder)
        case .weekdays(let data):
            try data.encode(to: encoder)
        case .yearlyDates(let data):
            try data.encode(to: encoder)
        }
    }

    /// Every occurrence of the listed days of the week.
    public struct Weekdays: Codable, Hashable, Sendable {
        public let dayType: String = "weekdays"
        /// The days of the week the window covers. Must not be empty.
        public let daysOfWeek: JSONValue
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            daysOfWeek: JSONValue,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.daysOfWeek = daysOfWeek
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.daysOfWeek = try container.decode(JSONValue.self, forKey: .daysOfWeek)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.dayType, forKey: .dayType)
            try container.encode(self.daysOfWeek, forKey: .daysOfWeek)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case dayType
            case daysOfWeek
        }
    }

    /// Fixed dates of the month, such as the 1st, the 15th, or the last day.
    public struct DayOfMonth: Codable, Hashable, Sendable {
        public let dayType: String = "dayOfMonth"
        /// The dates of the month the window covers, from 1 to 31, or from -1 to -31 to count back from the end of the month: -1 is the last day and -3 the third from last. Must not be empty. A date past the end of a month never matches it, so 31 and -31 skip 30-day months and February.
        public let days: JSONValue
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            days: JSONValue,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.days = days
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.days = try container.decode(JSONValue.self, forKey: .days)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.dayType, forKey: .dayType)
            try container.encode(self.days, forKey: .days)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case dayType
            case days
        }
    }

    /// Numbered occurrences within the month, such as the third Monday or the last weekday.
    public struct NthWeekday: Codable, Hashable, Sendable {
        public let dayType: String = "nthWeekday"
        /// The days of the week to count. Must not be empty.
        public let daysOfWeek: JSONValue
        /// Which of the counted days the window covers. Must not be empty.
        public let occurrences: JSONValue
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            daysOfWeek: JSONValue,
            occurrences: JSONValue,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.daysOfWeek = daysOfWeek
            self.occurrences = occurrences
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.daysOfWeek = try container.decode(JSONValue.self, forKey: .daysOfWeek)
            self.occurrences = try container.decode(JSONValue.self, forKey: .occurrences)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.dayType, forKey: .dayType)
            try container.encode(self.daysOfWeek, forKey: .daysOfWeek)
            try container.encode(self.occurrences, forKey: .occurrences)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case dayType
            case daysOfWeek
            case occurrences
        }
    }

    /// One run of dates every year, such as December 24 through January 2.
    public struct YearlyDates: Codable, Hashable, Sendable {
        public let dayType: String = "yearlyDates"
        /// The first date inside the range, e.g. "12-24".
        public let start: String
        /// The last date inside the range, e.g. "01-02".
        public let end: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            start: String,
            end: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.start = start
            self.end = end
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.start = try container.decode(String.self, forKey: .start)
            self.end = try container.decode(String.self, forKey: .end)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.dayType, forKey: .dayType)
            try container.encode(self.start, forKey: .start)
            try container.encode(self.end, forKey: .end)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case dayType
            case start
            case end
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case dayType
    }
}