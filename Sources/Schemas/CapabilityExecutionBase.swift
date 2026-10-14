import Foundation

public struct CapabilityExecutionBase: Codable, Hashable, Sendable {
    /// The capability that ran.
    public let capabilityId: EntityId
    /// What it ran for: a conversation, inbox item or event. The same shape `subjectIds`
    /// accepts, so it can be fed straight back in as a filter.
    /// 
    /// A deprecated `FEEDBACK_CREATED` trigger records a feedback here, which `subjectIds`
    /// cannot filter on. Switch those triggers to `EVENT_CREATED`.
    public let subjectId: EntityId
    public let status: CapabilityExecutionStatus
    /// Why the execution ended the way it did. Absent while RUNNING.
    public let completionReason: CapabilityExecutionCompletionReason?
    /// Detail from the app, truncated. Cleared when the subject conversation is
    /// wiped.
    public let message: String?
    /// When the execution began.
    public let startedAt: Date
    /// When it ended. Absent while RUNNING.
    public let completedAt: Date?
    /// End-to-end duration in milliseconds. Includes Maven's own work, so it is not purely the
    /// app's response time.
    public let durationMs: Int64?
    /// When the execution was recorded. Results are ordered by this field.
    public let createdAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        capabilityId: EntityId,
        subjectId: EntityId,
        status: CapabilityExecutionStatus,
        completionReason: CapabilityExecutionCompletionReason? = nil,
        message: String? = nil,
        startedAt: Date,
        completedAt: Date? = nil,
        durationMs: Int64? = nil,
        createdAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.capabilityId = capabilityId
        self.subjectId = subjectId
        self.status = status
        self.completionReason = completionReason
        self.message = message
        self.startedAt = startedAt
        self.completedAt = completedAt
        self.durationMs = durationMs
        self.createdAt = createdAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.capabilityId = try container.decode(EntityId.self, forKey: .capabilityId)
        self.subjectId = try container.decode(EntityId.self, forKey: .subjectId)
        self.status = try container.decode(CapabilityExecutionStatus.self, forKey: .status)
        self.completionReason = try container.decodeIfPresent(CapabilityExecutionCompletionReason.self, forKey: .completionReason)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.startedAt = try container.decode(Date.self, forKey: .startedAt)
        self.completedAt = try container.decodeIfPresent(Date.self, forKey: .completedAt)
        self.durationMs = try container.decodeIfPresent(Int64.self, forKey: .durationMs)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.capabilityId, forKey: .capabilityId)
        try container.encode(self.subjectId, forKey: .subjectId)
        try container.encode(self.status, forKey: .status)
        try container.encodeIfPresent(self.completionReason, forKey: .completionReason)
        try container.encodeIfPresent(self.message, forKey: .message)
        try container.encode(self.startedAt, forKey: .startedAt)
        try container.encodeIfPresent(self.completedAt, forKey: .completedAt)
        try container.encodeIfPresent(self.durationMs, forKey: .durationMs)
        try container.encode(self.createdAt, forKey: .createdAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case capabilityId
        case subjectId
        case status
        case completionReason
        case message
        case startedAt
        case completedAt
        case durationMs
        case createdAt
    }
}