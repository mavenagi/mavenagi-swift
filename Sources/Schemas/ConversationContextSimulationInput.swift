import Foundation

/// The conversation and user a capability runs in, supplied directly rather than read from an
/// existing conversation or agent user. Shared by every capability that runs inside a
/// conversation. Each field defaults to empty.
public struct ConversationContextSimulationInput: Codable, Hashable, Sendable {
    /// The conversation's metadata, as the capability would read it.
    public let conversationMetadata: [String: String]?
    /// The user the capability runs for. Omit it to run for an anonymous user.
    public let user: SimulatedUser?
    /// Data passed to the capability for this run only and never stored.
    public let transientData: [String: String]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        conversationMetadata: [String: String]? = nil,
        user: SimulatedUser? = nil,
        transientData: [String: String]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.conversationMetadata = conversationMetadata
        self.user = user
        self.transientData = transientData
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.conversationMetadata = try container.decodeIfPresent([String: String].self, forKey: .conversationMetadata)
        self.user = try container.decodeIfPresent(SimulatedUser.self, forKey: .user)
        self.transientData = try container.decodeIfPresent([String: String].self, forKey: .transientData)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.conversationMetadata, forKey: .conversationMetadata)
        try container.encodeIfPresent(self.user, forKey: .user)
        try container.encodeIfPresent(self.transientData, forKey: .transientData)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationMetadata
        case user
        case transientData
    }
}