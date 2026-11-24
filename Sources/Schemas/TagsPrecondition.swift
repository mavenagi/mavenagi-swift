import Foundation

/// Checks the conversation's tags against `tags`. The `operator` decides how:
/// 
/// - None: every listed tag must be present.
/// - `CONTAINS` or `CONTAINS_ANY`: at least one listed tag must be present.
/// - `NOT_CONTAINS` or `NOT_CONTAINS_ANY`: none of the listed tags may be present.
/// - `CONTAINS_ALL`: every listed tag must be present.
/// - `NOT_CONTAINS_ALL`: at least one listed tag must be missing.
/// - `NOT`: met unless every listed tag is present. To require that none are present, use
///   `NOT_CONTAINS_ANY`.
public struct TagsPrecondition: Codable, Hashable, Sendable {
    /// Operator to apply to this precondition
    public let `operator`: PreconditionOperator?
    /// The tags the `operator` checks the conversation's tags against.
    public let tags: JSONValue
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        operator: PreconditionOperator? = nil,
        tags: JSONValue,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.operator = `operator`
        self.tags = tags
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
        self.tags = try container.decode(JSONValue.self, forKey: .tags)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.operator, forKey: .operator)
        try container.encode(self.tags, forKey: .tags)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case `operator`
        case tags
    }
}