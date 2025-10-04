import Foundation

public struct AttachmentResponse: Codable, Hashable, Sendable {
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
    /// The URL to access the attachment, The URL will be valid for 20 minutes. Only present when status is `ACCEPTED`.
    public let url: String?
    /// The size of the attachment in bytes
    public let sizeBytes: Int64?
    /// The processing status of the attachment.
    public let status: AttachmentStatus
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: String,
        name: String? = nil,
        url: String? = nil,
        sizeBytes: Int64? = nil,
        status: AttachmentStatus,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.name = name
        self.url = url
        self.sizeBytes = sizeBytes
        self.status = status
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.sizeBytes = try container.decodeIfPresent(Int64.self, forKey: .sizeBytes)
        self.status = try container.decode(AttachmentStatus.self, forKey: .status)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.sizeBytes, forKey: .sizeBytes)
        try container.encode(self.status, forKey: .status)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case name
        case url
        case sizeBytes
        case status
    }
}