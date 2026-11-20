import Foundation

/// Not `UserData`, which requires `visibility`; a patch can leave it out.
public struct UserDataPatch: Codable, Hashable, Sendable {
    /// The value to store.
    public let value: String
    /// Defaults to `VISIBLE`.
    public let visibility: VisibilityType?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        value: String,
        visibility: VisibilityType? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.value = value
        self.visibility = visibility
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(String.self, forKey: .value)
        self.visibility = try container.decodeIfPresent(VisibilityType.self, forKey: .visibility)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.value, forKey: .value)
        try container.encodeIfPresent(self.visibility, forKey: .visibility)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case value
        case visibility
    }
}