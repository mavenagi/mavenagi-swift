import Foundation

/// A minute of the week, as a day of the week and a 24-hour `HH:mm` time on that day.
public struct WeekTime: Codable, Hashable, Sendable {
    public let dayOfWeek: DayOfWeek
    /// A 24-hour `HH:mm` time from "00:00" to "23:59", e.g. "18:00". To run to the end of Sunday, end on MONDAY at "00:00".
    public let time: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        dayOfWeek: DayOfWeek,
        time: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.dayOfWeek = dayOfWeek
        self.time = time
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dayOfWeek = try container.decode(DayOfWeek.self, forKey: .dayOfWeek)
        self.time = try container.decode(String.self, forKey: .time)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.dayOfWeek, forKey: .dayOfWeek)
        try container.encode(self.time, forKey: .time)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case dayOfWeek
        case time
    }
}