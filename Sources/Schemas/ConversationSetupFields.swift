import Foundation

/// The settings a conversation is created with.
public struct ConversationSetupFields: Codable, Hashable, Sendable {
    /// Optional configurations for responses to this conversation
    public let responseConfig: ResponseConfig?
    /// The tags of the conversation. Used for filtering in Agent Designer.
    public let tags: JSONValue?
    /// Set of 16 key-value pairs that can be attached to an object. This can be useful for storing
    /// additional information about the object in a structured format, and querying for objects
    /// via API or the dashboard.
    /// 
    /// Keys are strings with a maximum length of 500 characters. Values are strings with a maximum
    /// length of 512 characters.
    /// 
    /// The metadata of the conversation supplied by the app which created the conversation.
    public let metadata: [String: String]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        responseConfig: ResponseConfig? = nil,
        tags: JSONValue? = nil,
        metadata: [String: String]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.responseConfig = responseConfig
        self.tags = tags
        self.metadata = metadata
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.responseConfig = try container.decodeIfPresent(ResponseConfig.self, forKey: .responseConfig)
        self.tags = try container.decodeIfPresent(JSONValue.self, forKey: .tags)
        self.metadata = try container.decodeIfPresent([String: String].self, forKey: .metadata)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.responseConfig, forKey: .responseConfig)
        try container.encodeIfPresent(self.tags, forKey: .tags)
        try container.encodeIfPresent(self.metadata, forKey: .metadata)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case responseConfig
        case tags
        case metadata
    }
}