import Foundation

/// Attachments can be created either with inline data (up to 5MB) using the `content` field or by
/// referencing an asynchronously uploaded asset using the `assetId` field.
/// 
/// See the Assets APIs for more details on how to upload assets and get an asset ID.
/// 
/// <Tip>
///   Due to backwards compatibility, both the `type` field and the `name` field are present when attaching an Asset by ID.
///   These fields will be ignored in favor of the values supplied during the initial Asset upload.
///   They are only used for inline content uploads.
/// </Tip>
public struct AttachmentRequest: Codable, Hashable, Sendable {
    /// The mime-type of the attachment. Supported types are:
    /// - image/jpeg
    /// - image/jpg
    /// - image/png
    /// - image/gif
    /// - image/webp
    /// - application/pdf
    /// - text/plain
    /// - text/csv
    /// - application/vnd.openxmlformats-officedocument.wordprocessingml.document
    /// - application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
    /// - application/vnd.openxmlformats-officedocument.presentationml.presentation
    /// - application/msword
    /// - application/vnd.ms-excel
    /// - application/vnd.ms-powerpoint
    /// - audio/aac
    /// - audio/mpeg
    /// - audio/mp4
    /// - audio/wav
    /// - audio/ogg
    /// - video/mp4
    /// - video/webm
    public let type: String
    /// An optional name for the attachment.
    public let name: String?
    /// Inline attachment data, up to 5MB.
    public let content: String?
    /// The ID of an asynchronously uploaded asset.
    public let assetId: EntityIdBase?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: String,
        name: String? = nil,
        content: String? = nil,
        assetId: EntityIdBase? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.name = name
        self.content = content
        self.assetId = assetId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.assetId = try container.decodeIfPresent(EntityIdBase.self, forKey: .assetId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.content, forKey: .content)
        try container.encodeIfPresent(self.assetId, forKey: .assetId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case name
        case content
        case assetId
    }
}