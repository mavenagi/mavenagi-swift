import Foundation

public struct BrowserInfo: Codable, Hashable, Sendable {
    public let type: BrowserType
    public let name: String?
    public let version: String?
    public let userAgent: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: BrowserType,
        name: String? = nil,
        version: String? = nil,
        userAgent: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.name = name
        self.version = version
        self.userAgent = userAgent
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(BrowserType.self, forKey: .type)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.version = try container.decodeIfPresent(String.self, forKey: .version)
        self.userAgent = try container.decodeIfPresent(String.self, forKey: .userAgent)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.version, forKey: .version)
        try container.encodeIfPresent(self.userAgent, forKey: .userAgent)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case name
        case version
        case userAgent
    }
}