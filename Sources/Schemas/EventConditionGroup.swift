import Foundation

/// Combines event conditions with a logical operator. Groups nest, so `(a AND b) OR c` is a
/// group holding a group and a condition.
public struct EventConditionGroup: Codable, Hashable, Sendable {
    /// How to combine `conditions`.
    public let `operator`: PreconditionGroupOperator
    /// The conditions to combine. At least one is required; to match every event, omit the trigger's condition entirely.
    public let conditions: [EventCondition]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        operator: PreconditionGroupOperator,
        conditions: [EventCondition],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.operator = `operator`
        self.conditions = conditions
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operator = try container.decode(PreconditionGroupOperator.self, forKey: .operator)
        self.conditions = try container.decode([EventCondition].self, forKey: .conditions)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.operator, forKey: .operator)
        try container.encode(self.conditions, forKey: .conditions)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case `operator`
        case conditions
    }
}