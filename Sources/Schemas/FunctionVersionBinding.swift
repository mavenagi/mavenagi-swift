import Foundation

/// Binds a capability to one version of a Function. Both IDs carry the Function's app, which
/// must be the capability's own app.
public struct FunctionVersionBinding: Codable, Hashable, Sendable {
    /// The bound Function. `type` is `FUNCTION`.
    public let functionId: EntityIdWithoutAgent
    /// The version of that Function that runs. `type` is `FUNCTION_VERSION`.
    public let versionId: EntityIdWithoutAgent
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        functionId: EntityIdWithoutAgent,
        versionId: EntityIdWithoutAgent,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.functionId = functionId
        self.versionId = versionId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.functionId = try container.decode(EntityIdWithoutAgent.self, forKey: .functionId)
        self.versionId = try container.decode(EntityIdWithoutAgent.self, forKey: .versionId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.functionId, forKey: .functionId)
        try container.encode(self.versionId, forKey: .versionId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case functionId
        case versionId
    }
}