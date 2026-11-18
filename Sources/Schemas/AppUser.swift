import Foundation

public struct AppUser: Codable, Hashable, Sendable {
    /// Used to determine whether two users from different apps are the same
    public let identifiers: JSONValue
    /// Data about the user, keyed by field name.
    /// 
    /// Do not store credentials, tokens or other secrets here, whatever their `visibility`.
    /// User data is not secret storage: values are stored as given, and the users API returns
    /// them in full to callers that can read users. To pass a per-user credential to your
    /// app's actions, send it as `transientData` on the ask or submit-action-form request, which
    /// is forwarded to the actions of that request and not stored.
    public let data: [String: UserData]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        identifiers: JSONValue,
        data: [String: UserData],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.identifiers = identifiers
        self.data = data
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifiers = try container.decode(JSONValue.self, forKey: .identifiers)
        self.data = try container.decode([String: UserData].self, forKey: .data)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.identifiers, forKey: .identifiers)
        try container.encode(self.data, forKey: .data)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case identifiers
        case data
    }
}