import Foundation

public struct KnowledgeBaseProperties: Codable, Hashable, Sendable {
    /// The name of the knowledge base
    public let name: String
    /// Deprecated. Superseded by charters, which determine when knowledge bases and actions apply. Has no effect for agents using charters.
    /// 
    /// The preconditions that must be met for a knowledge base to be relevant to a conversation.
    public let precondition: Precondition?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        name: String,
        precondition: Precondition? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.name = name
        self.precondition = precondition
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.precondition = try container.decodeIfPresent(Precondition.self, forKey: .precondition)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.precondition, forKey: .precondition)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case precondition
    }
}