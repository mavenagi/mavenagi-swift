import Foundation

/// A type-independent check on whether an intelligent field is determined or
/// undetermined. Works for every field validationType.
public struct PresenceCondition: Codable, Hashable, Sendable {
    /// The presence operator to apply
    public let `operator`: PresenceOperator
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        operator: PresenceOperator,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.operator = `operator`
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operator = try container.decode(PresenceOperator.self, forKey: .operator)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.operator, forKey: .operator)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case `operator`
    }
}