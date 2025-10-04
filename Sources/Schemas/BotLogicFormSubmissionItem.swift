import Foundation

public struct BotLogicFormSubmissionItem: Codable, Hashable, Sendable {
    public let actionParameters: [String: ActionExecutionParamValue]
    public let executionResult: String?
    public let executionError: String?
    public let actionId: EntityIdWithoutAgent
    public let actionName: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        actionParameters: [String: ActionExecutionParamValue],
        executionResult: String? = nil,
        executionError: String? = nil,
        actionId: EntityIdWithoutAgent,
        actionName: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.actionParameters = actionParameters
        self.executionResult = executionResult
        self.executionError = executionError
        self.actionId = actionId
        self.actionName = actionName
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.actionParameters = try container.decode([String: ActionExecutionParamValue].self, forKey: .actionParameters)
        self.executionResult = try container.decodeIfPresent(String.self, forKey: .executionResult)
        self.executionError = try container.decodeIfPresent(String.self, forKey: .executionError)
        self.actionId = try container.decode(EntityIdWithoutAgent.self, forKey: .actionId)
        self.actionName = try container.decode(String.self, forKey: .actionName)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.actionParameters, forKey: .actionParameters)
        try container.encodeIfPresent(self.executionResult, forKey: .executionResult)
        try container.encodeIfPresent(self.executionError, forKey: .executionError)
        try container.encode(self.actionId, forKey: .actionId)
        try container.encode(self.actionName, forKey: .actionName)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case actionParameters
        case executionResult
        case executionError
        case actionId
        case actionName
    }
}