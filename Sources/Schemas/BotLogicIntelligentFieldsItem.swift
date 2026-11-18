import Foundation

/// The intelligent fields the agent's charters or segments refer to, with the values the
/// agent used for this step.
/// 
/// The agent evaluates these fields once per request that asks it to respond, before its
/// first step, and never between steps. Every step of that request reuses those values. So
/// when a response takes several steps, this item repeats in each step with the same values.
/// The repeat does not mean the fields were evaluated again.
public struct BotLogicIntelligentFieldsItem: Codable, Hashable, Sendable {
    /// The fields and their values, as evaluated before the request's first step.
    public let refreshedFields: [BotLogicIntelligentFieldDetail]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        refreshedFields: [BotLogicIntelligentFieldDetail],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.refreshedFields = refreshedFields
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.refreshedFields = try container.decode([BotLogicIntelligentFieldDetail].self, forKey: .refreshedFields)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.refreshedFields, forKey: .refreshedFields)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case refreshedFields
    }
}