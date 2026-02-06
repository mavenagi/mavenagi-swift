import Foundation

/// Condition checking membership in a set of strings
public struct StringMembershipCondition: Codable, Hashable, Sendable {
    /// The comparison operator to apply
    public let `operator`: StringMembershipOperator
    /// The set of string values to compare against
    public let values: [String]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        operator: StringMembershipOperator,
        values: [String],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.operator = `operator`
        self.values = values
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operator = try container.decode(StringMembershipOperator.self, forKey: .operator)
        self.values = try container.decode([String].self, forKey: .values)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.operator, forKey: .operator)
        try container.encode(self.values, forKey: .values)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case `operator`
        case values
    }
}