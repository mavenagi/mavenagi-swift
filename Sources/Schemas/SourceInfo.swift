import Foundation

public struct SourceInfo: Codable, Hashable, Sendable {
    public let type: SourceType
    public let deviceInfo: DeviceInfo?
    public let browserInfo: BrowserInfo?
    public let geoInfo: GeoInfo?
    public let ipInfo: IpInfo?
    public let languageInfo: LanguageInfo?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: SourceType,
        deviceInfo: DeviceInfo? = nil,
        browserInfo: BrowserInfo? = nil,
        geoInfo: GeoInfo? = nil,
        ipInfo: IpInfo? = nil,
        languageInfo: LanguageInfo? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.deviceInfo = deviceInfo
        self.browserInfo = browserInfo
        self.geoInfo = geoInfo
        self.ipInfo = ipInfo
        self.languageInfo = languageInfo
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(SourceType.self, forKey: .type)
        self.deviceInfo = try container.decodeIfPresent(DeviceInfo.self, forKey: .deviceInfo)
        self.browserInfo = try container.decodeIfPresent(BrowserInfo.self, forKey: .browserInfo)
        self.geoInfo = try container.decodeIfPresent(GeoInfo.self, forKey: .geoInfo)
        self.ipInfo = try container.decodeIfPresent(IpInfo.self, forKey: .ipInfo)
        self.languageInfo = try container.decodeIfPresent(LanguageInfo.self, forKey: .languageInfo)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.deviceInfo, forKey: .deviceInfo)
        try container.encodeIfPresent(self.browserInfo, forKey: .browserInfo)
        try container.encodeIfPresent(self.geoInfo, forKey: .geoInfo)
        try container.encodeIfPresent(self.ipInfo, forKey: .ipInfo)
        try container.encodeIfPresent(self.languageInfo, forKey: .languageInfo)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case deviceInfo
        case browserInfo
        case geoInfo
        case ipInfo
        case languageInfo
    }
}