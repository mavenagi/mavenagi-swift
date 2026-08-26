import Foundation

/// Refresh progress reported by the app that owns a knowledge base, surfaced to users while
/// a version is being built. Shared by the progress update request and the version response.
/// 
/// The `message` is always present. The two counts are optional but must be supplied
/// together - providing one without the other is rejected, since a progress bar needs both.
public struct KnowledgeBaseVersionProgress: Codable, Hashable, Sendable {
    /// A user-facing message describing what the refresh is currently doing.
    public let message: String
    /// How many units of work the refresh has finished so far. The numerator of a progress bar.
    /// Must be supplied together with `totalCount`.
    public let completedCount: Int64?
    /// How many units of work the refresh expects in total. The denominator of a progress bar.
    /// Must be supplied together with `completedCount`. Apps may revise this as a refresh
    /// discovers more work.
    public let totalCount: Int64?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        message: String,
        completedCount: Int64? = nil,
        totalCount: Int64? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.message = message
        self.completedCount = completedCount
        self.totalCount = totalCount
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.completedCount = try container.decodeIfPresent(Int64.self, forKey: .completedCount)
        self.totalCount = try container.decodeIfPresent(Int64.self, forKey: .totalCount)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.message, forKey: .message)
        try container.encodeIfPresent(self.completedCount, forKey: .completedCount)
        try container.encodeIfPresent(self.totalCount, forKey: .totalCount)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case message
        case completedCount
        case totalCount
    }
}