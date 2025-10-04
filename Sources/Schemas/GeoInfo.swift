import Foundation

public struct GeoInfo: Codable, Hashable, Sendable {
    public let city: String?
    public let state: String?
    public let country: String?
    public let region: String?
    public let latitude: Double?
    public let longitude: Double?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        city: String? = nil,
        state: String? = nil,
        country: String? = nil,
        region: String? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.city = city
        self.state = state
        self.country = country
        self.region = region
        self.latitude = latitude
        self.longitude = longitude
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.state = try container.decodeIfPresent(String.self, forKey: .state)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.region = try container.decodeIfPresent(String.self, forKey: .region)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.city, forKey: .city)
        try container.encodeIfPresent(self.state, forKey: .state)
        try container.encodeIfPresent(self.country, forKey: .country)
        try container.encodeIfPresent(self.region, forKey: .region)
        try container.encodeIfPresent(self.latitude, forKey: .latitude)
        try container.encodeIfPresent(self.longitude, forKey: .longitude)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case city
        case state
        case country
        case region
        case latitude
        case longitude
    }
}