import Foundation

public struct PatchAgentCapabilityRequest: Codable, Hashable, Sendable {
    /// Whether this capability is enabled or disabled
    public let enabled: Bool?
    /// Override description for action capabilities. Only applies to actions, ignored for triggers.
    public let descriptionOverride: Nullable<String>?
    /// Whether this action capability is pinned. Only applies to actions, ignored for triggers.
    public let pinned: Bool?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        enabled: Bool? = nil,
        descriptionOverride: Nullable<String>? = nil,
        pinned: Bool? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.enabled = enabled
        self.descriptionOverride = descriptionOverride
        self.pinned = pinned
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.descriptionOverride = try container.decodeNullableIfPresent(String.self, forKey: .descriptionOverride)
        self.pinned = try container.decodeIfPresent(Bool.self, forKey: .pinned)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.enabled, forKey: .enabled)
        try container.encodeNullableIfPresent(self.descriptionOverride, forKey: .descriptionOverride)
        try container.encodeIfPresent(self.pinned, forKey: .pinned)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case enabled
        case descriptionOverride
        case pinned
    }
}