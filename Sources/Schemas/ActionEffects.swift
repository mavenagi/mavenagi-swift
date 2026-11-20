import Foundation

/// State an action changes: metadata on its conversation, and data on the user whose message
/// triggered it. Must set at least one of `conversationMetadata` or `userData`, and an empty
/// map counts as unset.
public struct ActionEffects: Codable, Hashable, Sendable {
    /// Merged into the conversation's metadata. Keys and values are at most 500 characters
    /// each.
    public let conversationMetadata: [String: String]?
    /// A patch to the user's data. Keys may not start with `maven.`, which the platform
    /// reserves.
    public let userData: UserDataEffect?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        conversationMetadata: [String: String]? = nil,
        userData: UserDataEffect? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.conversationMetadata = conversationMetadata
        self.userData = userData
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.conversationMetadata = try container.decodeIfPresent([String: String].self, forKey: .conversationMetadata)
        self.userData = try container.decodeIfPresent(UserDataEffect.self, forKey: .userData)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.conversationMetadata, forKey: .conversationMetadata)
        try container.encodeIfPresent(self.userData, forKey: .userData)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationMetadata
        case userData
    }
}