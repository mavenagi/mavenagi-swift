import Foundation

/// What one simulated run of a capability produced, by kind.
public enum CapabilitySimulationResult: Codable, Hashable, Sendable {
    case action(Action)
    case conversationKickoff(ConversationKickoff)
    case trigger(Trigger)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .capabilityType)
        switch discriminant {
        case "ACTION":
            self = .action(try Action(from: decoder))
        case "CONVERSATION_KICKOFF":
            self = .conversationKickoff(try ConversationKickoff(from: decoder))
        case "TRIGGER":
            self = .trigger(try Trigger(from: decoder))
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown shape discriminant value: \(discriminant)"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws -> Void {
        switch self {
        case .action(let data):
            try data.encode(to: encoder)
        case .conversationKickoff(let data):
            try data.encode(to: encoder)
        case .trigger(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Action: Codable, Hashable, Sendable {
        public let capabilityType: String = "ACTION"
        /// The action's result. This is what the agent is given, whether it succeeded or failed.
        public let response: String
        /// Structured data returned alongside the response. Must serialize to fewer than 10,000 characters of JSON; data over that limit is omitted and the response is kept.
        public let data: [String: JSONValue]?
        /// Whether the action succeeded. Defaults to SUCCESS when absent.
        public let status: ActionExecutionStatus?
        /// Why the action failed, when status is ERROR. Never given to the agent. Truncated to 2,000 characters; a blank value is treated as if it were absent.
        public let errorMessage: String?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            response: String,
            data: [String: JSONValue]? = nil,
            status: ActionExecutionStatus? = nil,
            errorMessage: String? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.response = response
            self.data = data
            self.status = status
            self.errorMessage = errorMessage
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.response = try container.decode(String.self, forKey: .response)
            self.data = try container.decodeIfPresent([String: JSONValue].self, forKey: .data)
            self.status = try container.decodeIfPresent(ActionExecutionStatus.self, forKey: .status)
            self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.capabilityType, forKey: .capabilityType)
            try container.encode(self.response, forKey: .response)
            try container.encodeIfPresent(self.data, forKey: .data)
            try container.encodeIfPresent(self.status, forKey: .status)
            try container.encodeIfPresent(self.errorMessage, forKey: .errorMessage)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case capabilityType
            case response
            case data
            case status
            case errorMessage
        }
    }

    public struct ConversationKickoff: Codable, Hashable, Sendable {
        public let capabilityType: String = "CONVERSATION_KICKOFF"
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
            try container.encode(self.capabilityType, forKey: .capabilityType)
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
            case capabilityType
            case referenceId
            case appId
            case status
            case message
            case startedAt
            case completedAt
            case durationMs
        }
    }

    public struct Trigger: Codable, Hashable, Sendable {
        public let capabilityType: String = "TRIGGER"
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
        /// The kind of event that caused this run.
        public let eventType: EventTriggerType
        /// How a failure should be treated. Present only on FAILED executions.
        public let retryability: CapabilityExecutionRetryability?
        /// HTTP status returned by the app, when the failure carried one.
        public let httpStatus: Int?
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
            eventType: EventTriggerType,
            retryability: CapabilityExecutionRetryability? = nil,
            httpStatus: Int? = nil,
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
            self.eventType = eventType
            self.retryability = retryability
            self.httpStatus = httpStatus
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
            self.eventType = try container.decode(EventTriggerType.self, forKey: .eventType)
            self.retryability = try container.decodeIfPresent(CapabilityExecutionRetryability.self, forKey: .retryability)
            self.httpStatus = try container.decodeIfPresent(Int.self, forKey: .httpStatus)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.capabilityType, forKey: .capabilityType)
            try container.encode(self.capabilityId, forKey: .capabilityId)
            try container.encode(self.status, forKey: .status)
            try container.encodeIfPresent(self.completionReason, forKey: .completionReason)
            try container.encodeIfPresent(self.message, forKey: .message)
            try container.encode(self.startedAt, forKey: .startedAt)
            try container.encodeIfPresent(self.completedAt, forKey: .completedAt)
            try container.encodeIfPresent(self.durationMs, forKey: .durationMs)
            try container.encode(self.executionMode, forKey: .executionMode)
            try container.encode(self.eventType, forKey: .eventType)
            try container.encodeIfPresent(self.retryability, forKey: .retryability)
            try container.encodeIfPresent(self.httpStatus, forKey: .httpStatus)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case capabilityType
            case capabilityId
            case status
            case completionReason
            case message
            case startedAt
            case completedAt
            case durationMs
            case executionMode
            case eventType
            case retryability
            case httpStatus
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case capabilityType
    }
}