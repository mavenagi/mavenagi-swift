import Foundation

public struct TableResponseBase: Codable, Hashable, Sendable {
    /// Column headers in the table, aligning with the column definitions specified in the request.
    public let headers: [String]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        headers: [String],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.headers = headers
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.headers = try container.decode([String].self, forKey: .headers)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.headers, forKey: .headers)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case headers
    }
}