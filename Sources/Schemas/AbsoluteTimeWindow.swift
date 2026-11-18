import Foundation

/// A half-open span `[start, end)` between two instants. Set only `start` for "after", only
/// `end` for "before", or both for "between". At least one is required, and `start` must be
/// before `end` when both are set.
/// 
/// Both ends are instants with an offset, so a client converts a local date to an instant
/// before sending it; the server applies no timezone. The server keeps only the instant, so
/// a window reads back in UTC.
public struct AbsoluteTimeWindow: Codable, Hashable, Sendable {
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
        try container.encodeIfPresent(self.start, forKey: .start)
        try container.encodeIfPresent(self.end, forKey: .end)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case start
        case end
    }
}