import Foundation

/// A precondition based on the mode — voice or text — the conversation is running in.
/// 
/// The mode is set by the platform and is not customer-writable.
public struct ConversationModePrecondition: Codable, Hashable, Sendable {
    /// Operator to apply to this precondition
    public let `operator`: PreconditionOperator?
    /// The mode the conversation must be running in for the precondition to be met. Omit the operator for an exact match, or set it to NOT to invert (NOT + VOICE is equivalent to TEXT). Any other operator is rejected with a 400.
    public let conversationMode: ConversationMode
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        operator: PreconditionOperator? = nil,
        conversationMode: ConversationMode,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.operator = `operator`
        self.conversationMode = conversationMode
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
        self.conversationMode = try container.decode(ConversationMode.self, forKey: .conversationMode)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.operator, forKey: .operator)
        try container.encode(self.conversationMode, forKey: .conversationMode)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case `operator`
        case conversationMode
    }
}