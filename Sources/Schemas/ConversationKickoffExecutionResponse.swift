import Foundation

/// A single persisted Conversation Kickoff execution result, with timing.
public struct ConversationKickoffExecutionResponse: Codable, Hashable, Sendable {
    /// The kickoff config (external) id that ran.
    public let referenceId: String?
    /// The Maven app that registered the kickoff. Combined with referenceId this identifies
    /// the kickoff.
    public let appId: String?
    /// Whether the Conversation Kickoff completed successfully.
    public let status: ConversationKickoffStatus
    /// Additional detail about the Conversation Kickoff result.
    public let message: String?
    /// When the Conversation Kickoff started.
    public let startedAt: Date?
    /// When the Conversation Kickoff completed.
    public let completedAt: Date?
    /// How long the Conversation Kickoff took, in milliseconds.
    public let durationMs: Int64?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        referenceId: String? = nil,
        appId: String? = nil,
        status: ConversationKickoffStatus,
        message: String? = nil,
        startedAt: Date? = nil,
        completedAt: Date? = nil,
        durationMs: Int64? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.referenceId = referenceId
        self.appId = appId
        self.status = status
        self.message = message
        self.startedAt = startedAt
        self.completedAt = completedAt
        self.durationMs = durationMs
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.referenceId = try container.decodeIfPresent(String.self, forKey: .referenceId)
        self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
        self.status = try container.decode(ConversationKickoffStatus.self, forKey: .status)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.startedAt = try container.decodeIfPresent(Date.self, forKey: .startedAt)
        self.completedAt = try container.decodeIfPresent(Date.self, forKey: .completedAt)
        self.durationMs = try container.decodeIfPresent(Int64.self, forKey: .durationMs)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.referenceId, forKey: .referenceId)
        try container.encodeIfPresent(self.appId, forKey: .appId)
        try container.encode(self.status, forKey: .status)
        try container.encodeIfPresent(self.message, forKey: .message)
        try container.encodeIfPresent(self.startedAt, forKey: .startedAt)
        try container.encodeIfPresent(self.completedAt, forKey: .completedAt)
        try container.encodeIfPresent(self.durationMs, forKey: .durationMs)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case referenceId
        case appId
        case status
        case message
        case startedAt
        case completedAt
        case durationMs
    }
}