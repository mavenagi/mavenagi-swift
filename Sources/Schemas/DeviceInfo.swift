import Foundation

public struct DeviceInfo: Codable, Hashable, Sendable {
    public let type: DeviceType
    public let name: String?
    public let version: String?
    public let osInfo: OsInfo?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: DeviceType,
        name: String? = nil,
        version: String? = nil,
        osInfo: OsInfo? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.name = name
        self.version = version
        self.osInfo = osInfo
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(DeviceType.self, forKey: .type)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.version = try container.decodeIfPresent(String.self, forKey: .version)
        self.osInfo = try container.decodeIfPresent(OsInfo.self, forKey: .osInfo)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.version, forKey: .version)
        try container.encodeIfPresent(self.osInfo, forKey: .osInfo)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case name
        case version
        case osInfo
    }
}