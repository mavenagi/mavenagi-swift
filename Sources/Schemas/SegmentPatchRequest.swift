import Foundation

public struct SegmentPatchRequest: Codable, Hashable, Sendable {
    /// The App ID of the segment to update. If not provided, the ID of the calling app will be used.
    public let appId: String?
    /// The name of the segment.
    public let name: String?
    /// The precondition that must be met for a conversation message to be included in the segment.
    public let precondition: Precondition?
    /// The status of the segment. Segments can only be deactivated if they are not set on any actions or active knowledge bases.
    public let status: SegmentStatus?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        appId: String? = nil,
        name: String? = nil,
        precondition: Precondition? = nil,
        status: SegmentStatus? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.appId = appId
        self.name = name
        self.precondition = precondition
        self.status = status
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.precondition = try container.decodeIfPresent(Precondition.self, forKey: .precondition)
        self.status = try container.decodeIfPresent(SegmentStatus.self, forKey: .status)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.appId, forKey: .appId)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.precondition, forKey: .precondition)
        try container.encodeIfPresent(self.status, forKey: .status)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case appId
        case name
        case precondition
        case status
    }
}