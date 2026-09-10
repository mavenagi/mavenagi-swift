import Foundation

public struct BotLogicActionExecutedDetail: Codable, Hashable, Sendable {
    public let actionId: EntityIdWithoutAgent
    public let actionName: String
    public let actionParameters: [String: ActionExecutionParamValue]
    public let executionResult: String?
    public let executionError: String?
    /// Structured data the action returned alongside its text result. Absent for actions that returned only text.
    public let data: [String: JSONValue]?
    /// When the action invocation started. Absent for actions executed before per-action timing was recorded, and for an invocation that never returned — see `durationMs`.
    public let startedAt: Date?
    /// How long the action invocation took, in milliseconds. Measures the invocation itself, not the agent's surrounding reasoning.
    /// 
    /// Absent in two cases: actions executed before per-action timing was recorded, and actions whose invocation never returned a result — it timed out, or threw before completing. The second case matters when aggregating: the attempts with no duration are disproportionately the slowest ones, so a percentile computed over this field alone is biased low. Count `executionError` alongside it rather than treating absent as "fast".
    public let durationMs: Int64?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        actionId: EntityIdWithoutAgent,
        actionName: String,
        actionParameters: [String: ActionExecutionParamValue],
        executionResult: String? = nil,
        executionError: String? = nil,
        data: [String: JSONValue]? = nil,
        startedAt: Date? = nil,
        durationMs: Int64? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.actionId = actionId
        self.actionName = actionName
        self.actionParameters = actionParameters
        self.executionResult = executionResult
        self.executionError = executionError
        self.data = data
        self.startedAt = startedAt
        self.durationMs = durationMs
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.actionId = try container.decode(EntityIdWithoutAgent.self, forKey: .actionId)
        self.actionName = try container.decode(String.self, forKey: .actionName)
        self.actionParameters = try container.decode([String: ActionExecutionParamValue].self, forKey: .actionParameters)
        self.executionResult = try container.decodeIfPresent(String.self, forKey: .executionResult)
        self.executionError = try container.decodeIfPresent(String.self, forKey: .executionError)
        self.data = try container.decodeIfPresent([String: JSONValue].self, forKey: .data)
        self.startedAt = try container.decodeIfPresent(Date.self, forKey: .startedAt)
        self.durationMs = try container.decodeIfPresent(Int64.self, forKey: .durationMs)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.actionId, forKey: .actionId)
        try container.encode(self.actionName, forKey: .actionName)
        try container.encode(self.actionParameters, forKey: .actionParameters)
        try container.encodeIfPresent(self.executionResult, forKey: .executionResult)
        try container.encodeIfPresent(self.executionError, forKey: .executionError)
        try container.encodeIfPresent(self.data, forKey: .data)
        try container.encodeIfPresent(self.startedAt, forKey: .startedAt)
        try container.encodeIfPresent(self.durationMs, forKey: .durationMs)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case actionId
        case actionName
        case actionParameters
        case executionResult
        case executionError
        case data
        case startedAt
        case durationMs
    }
}