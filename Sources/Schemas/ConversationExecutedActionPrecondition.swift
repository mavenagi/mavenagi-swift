import Foundation

public struct ConversationExecutedActionPrecondition: Codable, Hashable, Sendable {
    /// Operator to apply to this precondition
    public let `operator`: PreconditionOperator?
    /// ID of an action that must have executed in this conversation for the precondition to be met
    public let actionId: String
    /// App ID that the given actionId belongs to. If not provided, the calling appId will be used.
    public let appId: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        operator: PreconditionOperator? = nil,
        actionId: String,
        appId: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.operator = `operator`
        self.actionId = actionId
        self.appId = appId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
        self.actionId = try container.decode(String.self, forKey: .actionId)
        self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.operator, forKey: .operator)
        try container.encode(self.actionId, forKey: .actionId)
        try container.encodeIfPresent(self.appId, forKey: .appId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case `operator`
        case actionId
        case appId
    }
}