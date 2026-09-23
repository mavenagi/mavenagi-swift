import Foundation

public struct CharterSearchFilter: Codable, Hashable, Sendable {
    /// Filter to charters that reference any of the specified actions (OR within this field).
    /// When combined with knowledgeBaseIds, both filters must match (AND across fields).
    /// An empty list is equivalent to omitting the field. Maximum 50 IDs.
    public let actionIds: [EntityId]?
    /// Filter to charters that reference any of the specified knowledge bases (OR within this field).
    /// When combined with actionIds, both filters must match (AND across fields).
    /// An empty list is equivalent to omitting the field. Maximum 50 IDs.
    public let knowledgeBaseIds: [EntityId]?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        actionIds: [EntityId]? = nil,
        knowledgeBaseIds: [EntityId]? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.actionIds = actionIds
        self.knowledgeBaseIds = knowledgeBaseIds
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.actionIds = try container.decodeIfPresent([EntityId].self, forKey: .actionIds)
        self.knowledgeBaseIds = try container.decodeIfPresent([EntityId].self, forKey: .knowledgeBaseIds)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.actionIds, forKey: .actionIds)
        try container.encodeIfPresent(self.knowledgeBaseIds, forKey: .knowledgeBaseIds)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case actionIds
        case knowledgeBaseIds
    }
}