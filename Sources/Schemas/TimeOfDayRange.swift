import Foundation

/// A half-open span of wall-clock time `[start, end)` on a matching day, as 24-hour `HH:mm`
/// strings in the window's timezone.
/// 
/// An `end` earlier than `start` wraps past midnight (22:00–02:00 runs overnight), and an `end`
/// of "00:00" means until midnight. `start` and `end` must differ: to cover the whole day, omit
/// `timeOfDay`.
public struct TimeOfDayRange: Codable, Hashable, Sendable {
    /// The first minute inside the range, e.g. "09:00".
    public let start: String
    /// The first minute after the range, e.g. "17:00".
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
        try container.encode(self.start, forKey: .start)
        try container.encode(self.end, forKey: .end)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case start
        case end
    }
}