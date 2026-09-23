import Foundation

/// Combines metadata filters with a logical operator. Groups nest, so `(a AND b) OR c`
/// is a group whose filters are a group and an entry.
public struct MetadataFilterGroup: Codable, Hashable, Sendable {
    /// How to combine `filters`.
    public let `operator`: PreconditionGroupOperator
    /// The filters to combine. At least one is required -- a group with no filters constrains
    /// nothing, and omitting the filter altogether already means every document.
    public let filters: [MetadataFilter]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        operator: PreconditionGroupOperator,
        filters: [MetadataFilter],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.operator = `operator`
        self.filters = filters
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operator = try container.decode(PreconditionGroupOperator.self, forKey: .operator)
        self.filters = try container.decode([MetadataFilter].self, forKey: .filters)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.operator, forKey: .operator)
        try container.encode(self.filters, forKey: .filters)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case `operator`
        case filters
    }
}