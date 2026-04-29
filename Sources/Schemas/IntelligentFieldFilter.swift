import Foundation

/// Filter conversations by intelligent field values. All conditions are ANDed.
public struct IntelligentFieldFilter: Codable, Hashable, Sendable {
    /// List of conditions to filter by. All conditions must match (AND logic).
    public let conditions: [IntelligentFieldSearchCondition]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        conditions: [IntelligentFieldSearchCondition],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.conditions = conditions
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.conditions = try container.decode([IntelligentFieldSearchCondition].self, forKey: .conditions)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.conditions, forKey: .conditions)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case conditions
    }
}