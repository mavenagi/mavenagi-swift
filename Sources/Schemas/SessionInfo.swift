import Foundation

public struct SessionInfo: Codable, Hashable, Sendable {
    public let id: String
    public let start: Date?
    public let end: Date?
    public let duration: Int64?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: String,
        start: Date? = nil,
        end: Date? = nil,
        duration: Int64? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.start = start
        self.end = end
        self.duration = duration
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.start = try container.decodeIfPresent(Date.self, forKey: .start)
        self.end = try container.decodeIfPresent(Date.self, forKey: .end)
        self.duration = try container.decodeIfPresent(Int64.self, forKey: .duration)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.start, forKey: .start)
        try container.encodeIfPresent(self.end, forKey: .end)
        try container.encodeIfPresent(self.duration, forKey: .duration)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case start
        case end
        case duration
    }
}