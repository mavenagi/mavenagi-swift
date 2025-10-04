import Foundation

public struct InitiateAssetUploadRequest: Codable, Hashable, Sendable {
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
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        type: String,
        name: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.type = type
        self.name = name
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.name, forKey: .name)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case name
    }
}