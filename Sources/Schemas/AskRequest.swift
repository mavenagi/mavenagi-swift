import Foundation

public struct AskRequest: Codable, Hashable, Sendable {
    /// Externally supplied ID to uniquely identify this message within the conversation. If a message with this ID already exists it will be reused and will not be updated.
    public let conversationMessageId: EntityIdBase
    /// Externally supplied ID to uniquely identify the user that created this message
    public let userId: EntityIdBase
    /// What prompts this assistant turn. Omit (or send USER_MESSAGE) for a normal user
    /// question — this is the backwards-compatible default. Use WELCOME for an agent-authored
    /// opener, or PROACTIVE for a message the user did not prompt.
    public let type: AskType?
    /// For USER_MESSAGE (the default) this is the user's message, in the user's own words, and
    /// is required. For WELCOME and PROACTIVE it is optional and, when provided, steers the
    /// agent's response (a directive to the agent, not the user's own words). (Changed from
    /// required to optional to support the non-user turn types — existing USER_MESSAGE callers
    /// are unaffected.)
    public let text: String?
    /// What form the answer takes. Omit it for prose, or send `jsonSchema` to additionally get a
    /// `BotObjectResponse` matching a schema you supply.
    /// 
    /// Set per ask and independent of `type`, so one conversation can mix prose and structured
    /// turns. Only the answer's form changes: knowledge, actions, charters and segments apply
    /// the same way either way.
    /// 
    /// A structured answer accompanies the prose one rather than replacing it — the same turn
    /// produces both, so the conversation stays readable. On `ask_stream` the prose still streams
    /// on `text` events as it always has, and the object arrives whole on a single `object` event
    /// near the end.
    /// 
    /// Every answering turn carries an object, including one where the agent asks a clarifying
    /// question rather than answering. Shape the schema so it can say "not enough information"
    /// — a populated object is not on its own evidence of a confident answer.
    /// 
    /// Two exceptions. A turn that asks the user to *act* produces an action form from the
    /// action rather than from an answer, so it carries no object; the turn that answers after
    /// the form is submitted does carry one. Leave the `FORMS` capability off if you need an
    /// object on every turn.
    /// 
    /// A turn answered verbatim by a `STRICT_RETURN` charter also carries no object. That
    /// charter's manual is returned exactly as written without consulting the agent, so there is
    /// nothing to shape into the requested schema — the turn returns the manual as `text` alone.
    public let textFormat: TextFormat?
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
        type: AskType? = nil,
        text: String? = nil,
        textFormat: TextFormat? = nil,
        attachments: [AttachmentRequest]? = nil,
        transientData: [String: String]? = nil,
        timezone: String? = nil,
        appMetadata: [String: String]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.conversationMessageId = conversationMessageId
        self.userId = userId
        self.type = type
        self.text = text
        self.textFormat = textFormat
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
        self.type = try container.decodeIfPresent(AskType.self, forKey: .type)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.textFormat = try container.decodeIfPresent(TextFormat.self, forKey: .textFormat)
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
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.text, forKey: .text)
        try container.encodeIfPresent(self.textFormat, forKey: .textFormat)
        try container.encodeIfPresent(self.attachments, forKey: .attachments)
        try container.encodeIfPresent(self.transientData, forKey: .transientData)
        try container.encodeIfPresent(self.timezone, forKey: .timezone)
        try container.encodeIfPresent(self.appMetadata, forKey: .appMetadata)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationMessageId
        case userId
        case type
        case text
        case textFormat
        case attachments
        case transientData
        case timezone
        case appMetadata
    }
}