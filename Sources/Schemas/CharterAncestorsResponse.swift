import Foundation

public struct CharterAncestorsResponse: Codable, Hashable, Sendable {
    /// The requested charter and all of its ancestors up to the root,
    /// ordered from root to leaf. The last element is the requested charter.
    public let charters: [CharterResponse]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        charters: [CharterResponse],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.charters = charters
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.charters = try container.decode([CharterResponse].self, forKey: .charters)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.charters, forKey: .charters)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case charters
    }
}