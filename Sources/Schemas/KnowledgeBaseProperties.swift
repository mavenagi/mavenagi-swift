import Foundation

public struct KnowledgeBaseProperties: Codable, Hashable, Sendable {
    /// The name of the knowledge base
    public let name: String
    /// The preconditions that must be met for knowledge base be relevant to a conversation. Can be used to restrict knowledge bases to certain types of users.
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