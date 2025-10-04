import Foundation

public struct InboxItemFixDeactivateDocument: Codable, Hashable, Sendable {
    /// Unique identifier for the inbox item fix.
    public let id: EntityId
    /// Information about the document associated with this fix.
    public let documentInformation: DocumentInformation
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: EntityId,
        documentInformation: DocumentInformation,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.documentInformation = documentInformation
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(EntityId.self, forKey: .id)
        self.documentInformation = try container.decode(DocumentInformation.self, forKey: .documentInformation)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.documentInformation, forKey: .documentInformation)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case documentInformation
    }
}