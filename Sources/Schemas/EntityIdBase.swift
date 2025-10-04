import Foundation

/// All other entityId fields are inferred from the API request.
public struct EntityIdBase: Codable, Hashable, Sendable {
    /// Externally supplied ID to uniquely identify this object. Is globally unique when combined with all other entityId fields (type, appId, organizationId, agentId)
    public let referenceId: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        referenceId: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.referenceId = referenceId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.referenceId = try container.decode(String.self, forKey: .referenceId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.referenceId, forKey: .referenceId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case referenceId
    }
}