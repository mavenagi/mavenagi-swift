import Foundation

/// The dates from `start` through `end`, both included, every year, as `MM-DD` strings. An `end`
/// earlier in the year than `start` wraps past New Year: `12-24` through `01-02` covers the last
/// eight days of December and the first two of January. An `end` equal to `start` covers that
/// one date.
/// 
/// Both must be real dates. `start` cannot be February 29, since most years lack it. An `end`
/// of `02-29` runs through the last day of February in every year, and a range that spans it,
/// such as `02-28` through `03-01`, covers it in leap years.
public struct YearlyDatesDaySelector: Codable, Hashable, Sendable {
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
        try container.encode(self.start, forKey: .start)
        try container.encode(self.end, forKey: .end)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case start
        case end
    }
}