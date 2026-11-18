import Foundation

/// How one run of one capability went: its outcome and timing. Every execution has these, and a
/// simulated run, which is never recorded, has only these.
public struct CapabilityRunBase: Codable, Hashable, Sendable {
    /// The capability that ran.
    public let capabilityId: EntityId
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
    /// Whether the execution ran on live data or in a simulation. A Conversation Kickoff takes
    /// its conversation's mode, and an Event Trigger its event's.
    public let executionMode: ExecutionMode
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        capabilityId: EntityId,
        status: CapabilityExecutionStatus,
        completionReason: CapabilityExecutionCompletionReason? = nil,
        message: String? = nil,
        startedAt: Date,
        completedAt: Date? = nil,
        durationMs: Int64? = nil,
        executionMode: ExecutionMode,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.capabilityId = capabilityId
        self.status = status
        self.completionReason = completionReason
        self.message = message
        self.startedAt = startedAt
        self.completedAt = completedAt
        self.durationMs = durationMs
        self.executionMode = executionMode
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.capabilityId = try container.decode(EntityId.self, forKey: .capabilityId)
        self.status = try container.decode(CapabilityExecutionStatus.self, forKey: .status)
        self.completionReason = try container.decodeIfPresent(CapabilityExecutionCompletionReason.self, forKey: .completionReason)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.startedAt = try container.decode(Date.self, forKey: .startedAt)
        self.completedAt = try container.decodeIfPresent(Date.self, forKey: .completedAt)
        self.durationMs = try container.decodeIfPresent(Int64.self, forKey: .durationMs)
        self.executionMode = try container.decode(ExecutionMode.self, forKey: .executionMode)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.capabilityId, forKey: .capabilityId)
        try container.encode(self.status, forKey: .status)
        try container.encodeIfPresent(self.completionReason, forKey: .completionReason)
        try container.encodeIfPresent(self.message, forKey: .message)
        try container.encode(self.startedAt, forKey: .startedAt)
        try container.encodeIfPresent(self.completedAt, forKey: .completedAt)
        try container.encodeIfPresent(self.durationMs, forKey: .durationMs)
        try container.encode(self.executionMode, forKey: .executionMode)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case capabilityId
        case status
        case completionReason
        case message
        case startedAt
        case completedAt
        case durationMs
        case executionMode
    }
}