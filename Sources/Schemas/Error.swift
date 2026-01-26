import Foundation

/// Error occurred during conversation
public struct Error: Codable, Hashable, Sendable {
    public let eventId: String
    public let type: Error
    public let message: String
    public let code: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        eventId: String,
        type: Error,
        message: String,
        code: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.eventId = eventId
        self.type = type
        self.message = message
        self.code = code
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventId = try container.decode(String.self, forKey: .eventId)
        self.type = try container.decode(Error.self, forKey: .type)
        self.message = try container.decode(String.self, forKey: .message)
        self.code = try container.decode(String.self, forKey: .code)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.eventId, forKey: .eventId)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.message, forKey: .message)
        try container.encode(self.code, forKey: .code)
    }

    public enum Error: String, Codable, Hashable, CaseIterable, Sendable {
        case error
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case eventId
        case type
        case message
        case code
    }
}