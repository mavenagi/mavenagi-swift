import Foundation

public struct WeekdaysDaySelector: Codable, Hashable, Sendable {
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
        try container.encode(self.daysOfWeek, forKey: .daysOfWeek)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case daysOfWeek
    }
}