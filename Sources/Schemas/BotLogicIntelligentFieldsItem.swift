import Foundation

public struct BotLogicIntelligentFieldsItem: Codable, Hashable, Sendable {
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