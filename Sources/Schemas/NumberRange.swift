import Foundation

/// A range of numbers that can be used to filter search results by numeric fields.
/// - `greaterThanOrEqual`: The minimum value (inclusive).
/// - `lessThan`: The maximum value (exclusive).
public struct NumberRange: Codable, Hashable, Sendable {
    public let greaterThanOrEqual: Int?
    public let lessThan: Int?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        greaterThanOrEqual: Int? = nil,
        lessThan: Int? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.greaterThanOrEqual = greaterThanOrEqual
        self.lessThan = lessThan
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.greaterThanOrEqual = try container.decodeIfPresent(Int.self, forKey: .greaterThanOrEqual)
        self.lessThan = try container.decodeIfPresent(Int.self, forKey: .lessThan)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.greaterThanOrEqual, forKey: .greaterThanOrEqual)
        try container.encodeIfPresent(self.lessThan, forKey: .lessThan)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case greaterThanOrEqual
        case lessThan
    }
}