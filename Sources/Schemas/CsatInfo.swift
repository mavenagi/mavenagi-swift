import Foundation

public struct CsatInfo: Codable, Hashable, Sendable {
    /// The rating of the CSAT rating
    public let rating: Double?
    /// The max rating of the CSAT value (default 5)
    public let maxRating: Double?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        rating: Double? = nil,
        maxRating: Double? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.rating = rating
        self.maxRating = maxRating
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        self.maxRating = try container.decodeIfPresent(Double.self, forKey: .maxRating)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.rating, forKey: .rating)
        try container.encodeIfPresent(self.maxRating, forKey: .maxRating)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case rating
        case maxRating
    }
}