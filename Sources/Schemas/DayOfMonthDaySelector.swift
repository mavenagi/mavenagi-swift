import Foundation

public struct DayOfMonthDaySelector: Codable, Hashable, Sendable {
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
        try container.encode(self.days, forKey: .days)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case days
    }
}