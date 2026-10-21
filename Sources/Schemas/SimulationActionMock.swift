import Foundation

public struct SimulationActionMock: Codable, Hashable, Sendable {
    /// The action this entry applies to.
    public let actionId: EntityIdWithoutAgent
    public let behavior: SimulationActionBehavior
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        actionId: EntityIdWithoutAgent,
        behavior: SimulationActionBehavior,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.actionId = actionId
        self.behavior = behavior
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.actionId = try container.decode(EntityIdWithoutAgent.self, forKey: .actionId)
        self.behavior = try container.decode(SimulationActionBehavior.self, forKey: .behavior)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.actionId, forKey: .actionId)
        try container.encode(self.behavior, forKey: .behavior)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case actionId
        case behavior
    }
}