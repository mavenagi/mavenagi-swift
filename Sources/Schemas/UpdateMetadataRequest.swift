import Foundation

public struct UpdateMetadataRequest: Codable, Hashable, Sendable {
    /// The App ID of the conversation to modify metadata for. If not provided the ID of the calling app will be used.
    public let appId: String?
    /// The metadata values to add to the conversation.
    public let values: [String: String]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        appId: String? = nil,
        values: [String: String],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.appId = appId
        self.values = values
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
        self.values = try container.decode([String: String].self, forKey: .values)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.appId, forKey: .appId)
        try container.encode(self.values, forKey: .values)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case appId
        case values
    }
}