import Foundation

public struct ConversationExecutedActionPrecondition: Codable, Hashable, Sendable {
    /// Operator to apply to this precondition
    public let `operator`: PreconditionOperator?
    /// ID of an action that must have executed in this conversation for the precondition to be met
    public let actionId: String
    /// App ID that the given actionId belongs to. If not provided, the calling appId will be used.
    public let appId: String?
    /// Restricts which round the action must have executed in. Defaults to ANY when omitted, matching an action executed in any round.
    public let conversationRound: ConversationRound?
    /// Restricts the match to executions whose returned data satisfies this condition.
    /// When omitted, any execution of the action matches regardless of what it returned.
    /// 
    /// Actions may return `{response, data}`, where `data` is a JSON object persisted
    /// alongside the response. This gates the precondition on what the action returned
    /// rather than only on whether it ran.
    /// 
    /// The precondition is met when *some* execution of the action in scope returned data
    /// satisfying this condition. An action that executed but returned no data never
    /// matches, except via `universal` `IS_UNDETERMINED`.
    public let dataCondition: ObjectCondition?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        operator: PreconditionOperator? = nil,
        actionId: String,
        appId: String? = nil,
        conversationRound: ConversationRound? = nil,
        dataCondition: ObjectCondition? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.operator = `operator`
        self.actionId = actionId
        self.appId = appId
        self.conversationRound = conversationRound
        self.dataCondition = dataCondition
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
        self.actionId = try container.decode(String.self, forKey: .actionId)
        self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
        self.conversationRound = try container.decodeIfPresent(ConversationRound.self, forKey: .conversationRound)
        self.dataCondition = try container.decodeIfPresent(ObjectCondition.self, forKey: .dataCondition)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.operator, forKey: .operator)
        try container.encode(self.actionId, forKey: .actionId)
        try container.encodeIfPresent(self.appId, forKey: .appId)
        try container.encodeIfPresent(self.conversationRound, forKey: .conversationRound)
        try container.encodeIfPresent(self.dataCondition, forKey: .dataCondition)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case `operator`
        case actionId
        case appId
        case conversationRound
        case dataCondition
    }
}