import Foundation

public struct UserDataEffect: Codable, Hashable, Sendable {
    /// Keys to set. Keys not named are left as they are.
    public let data: [String: UserDataPatch]?
    /// Keys to clear. Each is set to an empty string with `VISIBLE` visibility; there is no
    /// delete. A key may not also appear in `data`.
    public let removeKeys: [String]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        data: [String: UserDataPatch]? = nil,
        removeKeys: [String]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.data = data
        self.removeKeys = removeKeys
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent([String: UserDataPatch].self, forKey: .data)
        self.removeKeys = try container.decodeIfPresent([String].self, forKey: .removeKeys)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.data, forKey: .data)
        try container.encodeIfPresent(self.removeKeys, forKey: .removeKeys)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case data
        case removeKeys
    }
}