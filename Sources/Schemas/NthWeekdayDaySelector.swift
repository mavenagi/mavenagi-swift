import Foundation

/// Picks days by counting, within each month, the days that fall on any of `daysOfWeek`, and
/// keeping the occurrences listed.
/// 
/// With a single day of the week this reads naturally: `[MONDAY]` with `[THIRD]` is the third
/// Monday. With several, the count runs across all of them: Monday through Friday with `[LAST]`
/// is the last weekday of the month, not the last Monday, last Tuesday, and so on.
public struct NthWeekdayDaySelector: Codable, Hashable, Sendable {
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
        try container.encode(self.daysOfWeek, forKey: .daysOfWeek)
        try container.encode(self.occurrences, forKey: .occurrences)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case daysOfWeek
        case occurrences
    }
}