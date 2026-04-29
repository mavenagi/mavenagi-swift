import Foundation

/// A single condition on an intelligent field value.
public struct IntelligentFieldSearchCondition: Codable, Hashable, Sendable {
    /// The intelligent field to filter on (referenceId + appId)
    public let fieldId: EntityIdFilter
    /// The comparison operator to apply
    public let `operator`: IntelligentFieldOperator
    /// The value to compare against. Required for all operators except EXISTS and NOT_EXISTS. For BOOLEAN fields use "true" or "false". For NUMBER fields use a numeric string.
    public let value: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        fieldId: EntityIdFilter,
        operator: IntelligentFieldOperator,
        value: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.fieldId = fieldId
        self.operator = `operator`
        self.value = value
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fieldId = try container.decode(EntityIdFilter.self, forKey: .fieldId)
        self.operator = try container.decode(IntelligentFieldOperator.self, forKey: .operator)
        self.value = try container.decodeIfPresent(String.self, forKey: .value)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.fieldId, forKey: .fieldId)
        try container.encode(self.operator, forKey: .operator)
        try container.encodeIfPresent(self.value, forKey: .value)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case fieldId
        case `operator`
        case value
    }
}