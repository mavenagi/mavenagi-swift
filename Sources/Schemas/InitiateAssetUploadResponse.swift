import Foundation

public struct InitiateAssetUploadResponse: Codable, Hashable, Sendable {
    /// The ID of the asset. Use this ID to commit the asset after upload.
    public let assetId: EntityIdBase
    /// Pre-signed URL for file upload. Use this URL to upload the file directly to storage.
    public let uploadUrl: String
    /// The expiration time for the upload URL
    public let expiresAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        assetId: EntityIdBase,
        uploadUrl: String,
        expiresAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.assetId = assetId
        self.uploadUrl = uploadUrl
        self.expiresAt = expiresAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.assetId = try container.decode(EntityIdBase.self, forKey: .assetId)
        self.uploadUrl = try container.decode(String.self, forKey: .uploadUrl)
        self.expiresAt = try container.decode(Date.self, forKey: .expiresAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.assetId, forKey: .assetId)
        try container.encode(self.uploadUrl, forKey: .uploadUrl)
        try container.encode(self.expiresAt, forKey: .expiresAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case assetId
        case uploadUrl
        case expiresAt
    }
}