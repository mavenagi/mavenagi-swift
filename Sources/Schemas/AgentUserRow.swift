import Foundation

public struct AgentUserRow: Codable, Hashable, Sendable {
    /// The actual row data, where keys represent column headers and values contain the respective metric results.
    public let data: [String: CellData]
    /// A unique identifier for each row, consisting of field names mapped to their respective values.
    /// This includes time groupings and any specified field groupings.
    public let identifier: [AgentUserField: FieldValue]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        data: [String: CellData],
        identifier: [AgentUserField: FieldValue],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.data = data
        self.identifier = identifier
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([String: CellData].self, forKey: .data)
        self.identifier = try container.decode([AgentUserField: FieldValue].self, forKey: .identifier)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.data, forKey: .data)
        try container.encode(self.identifier, forKey: .identifier)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case data
        case identifier
    }
}