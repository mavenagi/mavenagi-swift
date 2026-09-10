import Foundation

public struct GetDirectoryAppSettingDownloadUrlResponse: Codable, Hashable, Sendable {
    public let downloadUrl: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        downloadUrl: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.downloadUrl = downloadUrl
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.downloadUrl = try container.decode(String.self, forKey: .downloadUrl)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.downloadUrl, forKey: .downloadUrl)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case downloadUrl
    }
}