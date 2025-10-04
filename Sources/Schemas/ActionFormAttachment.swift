import Foundation

public struct ActionFormAttachment: Codable, Hashable, Sendable {
    /// The asset ID of the attachment.
    public let assetId: EntityIdBase
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        assetId: EntityIdBase,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.assetId = assetId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.assetId = try container.decode(EntityIdBase.self, forKey: .assetId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.assetId, forKey: .assetId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case assetId
    }
}