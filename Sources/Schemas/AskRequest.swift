import Foundation

public struct AskRequest: Codable, Hashable, Sendable {
    /// Externally supplied ID to uniquely identify this message within the conversation. If a message with this ID already exists it will be reused and will not be updated.
    public let conversationMessageId: EntityIdBase
    /// Externally supplied ID to uniquely identify the user that created this message
    public let userId: EntityIdBase
    /// The text of the message
    public let text: String
    /// The attachments to the message. Image attachments will be sent to the LLM as additional data.
    /// Non-image attachments can be stored and downloaded from the API but will not be sent to the LLM.
    public let attachments: [AttachmentRequest]?
    /// Transient data which the Maven platform will not persist. This data will only be forwarded to actions taken by this ask request. For example, one may put in user tokens as transient data.
    public let transientData: [String: String]?
    /// IANA timezone identifier (e.g. "America/New_York", "Europe/London") to be used for time-based operations in the conversation.
    public let timezone: String?
    /// Key-value metadata to persist on the user message created by this request. Unlike
    /// `transientData` (which is never persisted) this is stored and returned when the message
    /// is read back via the API or dashboard, and unlike user data it is not sent to the LLM.
    /// Applied only when the message is first created — if `conversationMessageId` already
    /// exists the message is reused and its metadata is not updated. Keys and values are strings
    /// with a maximum length of 500 characters each.
    public let appMetadata: [String: String]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        conversationMessageId: EntityIdBase,
        userId: EntityIdBase,
        text: String,
        attachments: [AttachmentRequest]? = nil,
        transientData: [String: String]? = nil,
        timezone: String? = nil,
        appMetadata: [String: String]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.conversationMessageId = conversationMessageId
        self.userId = userId
        self.text = text
        self.attachments = attachments
        self.transientData = transientData
        self.timezone = timezone
        self.appMetadata = appMetadata
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.conversationMessageId = try container.decode(EntityIdBase.self, forKey: .conversationMessageId)
        self.userId = try container.decode(EntityIdBase.self, forKey: .userId)
        self.text = try container.decode(String.self, forKey: .text)
        self.attachments = try container.decodeIfPresent([AttachmentRequest].self, forKey: .attachments)
        self.transientData = try container.decodeIfPresent([String: String].self, forKey: .transientData)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        self.appMetadata = try container.decodeIfPresent([String: String].self, forKey: .appMetadata)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.conversationMessageId, forKey: .conversationMessageId)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.text, forKey: .text)
        try container.encodeIfPresent(self.attachments, forKey: .attachments)
        try container.encodeIfPresent(self.transientData, forKey: .transientData)
        try container.encodeIfPresent(self.timezone, forKey: .timezone)
        try container.encodeIfPresent(self.appMetadata, forKey: .appMetadata)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationMessageId
        case userId
        case text
        case attachments
        case transientData
        case timezone
        case appMetadata
    }
}