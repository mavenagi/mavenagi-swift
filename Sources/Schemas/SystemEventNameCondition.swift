import Foundation

/// A condition on the name of a system event. Matches system events only.
public struct SystemEventNameCondition: Codable, Hashable, Sendable {
    /// The membership operator to apply.
    public let `operator`: StringMembershipOperator
    /// The system event names to match, at most 50. At least one is required.
    public let names: [SystemEventName]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        operator: StringMembershipOperator,
        names: [SystemEventName],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.operator = `operator`
        self.names = names
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operator = try container.decode(StringMembershipOperator.self, forKey: .operator)
        self.names = try container.decode([SystemEventName].self, forKey: .names)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.operator, forKey: .operator)
        try container.encode(self.names, forKey: .names)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case `operator`
        case names
    }
}