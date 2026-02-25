import Foundation

/// Filter criteria for searching segments.
public struct SegmentFilter: Codable, Hashable, Sendable {
    /// Filter segments by name. Case-insensitive substring match.
    /// Empty string returns all results.
    public let name: String?
    /// Filter segments by description. Case-insensitive substring match.
    /// Empty string returns all results.
    public let description: String?
    /// Filter segments by status. Returns segments matching any of the provided statuses.
    /// Empty list returns all non-deleted results.
    public let statuses: [SegmentStatus]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String? = nil,
        description: String? = nil,
        statuses: [SegmentStatus]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.description = description
        self.statuses = statuses
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.statuses = try container.decodeIfPresent([SegmentStatus].self, forKey: .statuses)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.statuses, forKey: .statuses)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case description
        case statuses
    }
}