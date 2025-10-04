import Foundation

public struct ConversationPatchRequest: Codable, Hashable, Sendable {
    /// The App ID of the conversation to patch. If not provided the ID of the calling app will be used.
    public let appId: String?
    /// Whether the conversation is able to receive asynchronous messages. Only valid for conversations with the `ASYNC` capability.
    public let open: Bool?
    /// Whether the LLM is enabled for this conversation.
    public let llmEnabled: Bool?
    /// A list of attachments to add to the conversation. Attachments can only be appended. Removal is not allowed.
    public let attachments: [AttachmentRequest]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        appId: String? = nil,
        open: Bool? = nil,
        llmEnabled: Bool? = nil,
        attachments: [AttachmentRequest]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.appId = appId
        self.open = open
        self.llmEnabled = llmEnabled
        self.attachments = attachments
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
        self.open = try container.decodeIfPresent(Bool.self, forKey: .open)
        self.llmEnabled = try container.decodeIfPresent(Bool.self, forKey: .llmEnabled)
        self.attachments = try container.decodeIfPresent([AttachmentRequest].self, forKey: .attachments)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.appId, forKey: .appId)
        try container.encodeIfPresent(self.open, forKey: .open)
        try container.encodeIfPresent(self.llmEnabled, forKey: .llmEnabled)
        try container.encodeIfPresent(self.attachments, forKey: .attachments)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case appId
        case open
        case llmEnabled
        case attachments
    }
}