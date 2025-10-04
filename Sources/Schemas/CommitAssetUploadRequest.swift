import Foundation

public struct CommitAssetUploadRequest: Codable, Hashable, Sendable {
    /// Checksum of the uploaded file (optional verification)
    public let checksum: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        checksum: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.checksum = checksum
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.checksum = try container.decodeIfPresent(String.self, forKey: .checksum)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.checksum, forKey: .checksum)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case checksum
    }
}