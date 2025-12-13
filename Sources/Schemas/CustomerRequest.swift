import Foundation

public struct CustomerRequest: Codable, Hashable, Sendable {
    /// ID that uniquely identifies this customer
    public let customerId: EntityIdBase
    public let name: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        customerId: EntityIdBase,
        name: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.customerId = customerId
        self.name = name
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.customerId = try container.decode(EntityIdBase.self, forKey: .customerId)
        self.name = try container.decode(String.self, forKey: .name)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.customerId, forKey: .customerId)
        try container.encode(self.name, forKey: .name)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case customerId
        case name
    }
}