import Foundation

public struct MetadataPrecondition: Codable, Hashable, Sendable {
    /// Operator to apply to this precondition
    public let `operator`: PreconditionOperator?
    /// The key that must be present in the metadata for a precondition to be met
    public let key: String
    /// If set, the value must match the metadata value for the given key
    public let value: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        operator: PreconditionOperator? = nil,
        key: String,
        value: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.operator = `operator`
        self.key = key
        self.value = value
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
        self.key = try container.decode(String.self, forKey: .key)
        self.value = try container.decodeIfPresent(String.self, forKey: .value)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.operator, forKey: .operator)
        try container.encode(self.key, forKey: .key)
        try container.encodeIfPresent(self.value, forKey: .value)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case `operator`
        case key
        case value
    }
}