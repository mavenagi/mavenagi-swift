import Foundation

public struct EntityResult: Codable, Hashable, Sendable {
    public let referenceId: String
    public let appId: String
    /// Human-readable name for the referenced entity (e.g., action name or document title).
    public let name: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        referenceId: String,
        appId: String,
        name: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.referenceId = referenceId
        self.appId = appId
        self.name = name
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.referenceId = try container.decode(String.self, forKey: .referenceId)
        self.appId = try container.decode(String.self, forKey: .appId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.referenceId, forKey: .referenceId)
        try container.encode(self.appId, forKey: .appId)
        try container.encodeIfPresent(self.name, forKey: .name)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case referenceId
        case appId
        case name
    }
}