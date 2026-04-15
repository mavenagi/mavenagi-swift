import Foundation

public struct PreconditionGroupResponse: Codable, Hashable, Sendable {
    public let `operator`: PreconditionGroupOperator
    public let preconditions: [PreconditionResponse]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        operator: PreconditionGroupOperator,
        preconditions: [PreconditionResponse],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.operator = `operator`
        self.preconditions = preconditions
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.operator = try container.decode(PreconditionGroupOperator.self, forKey: .operator)
        self.preconditions = try container.decode([PreconditionResponse].self, forKey: .preconditions)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.operator, forKey: .operator)
        try container.encode(self.preconditions, forKey: .preconditions)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case `operator`
        case preconditions
    }
}