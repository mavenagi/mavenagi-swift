import Foundation

public struct ErrorMessage: Codable, Hashable, Sendable {
    /// HTTP status code returned by the API.
    public let status: Int?
    /// HTTP reason phrase for the status code.
    public let error: String?
    /// Human-readable error details.
    public let message: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        status: Int? = nil,
        error: String? = nil,
        message: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.status = status
        self.error = error
        self.message = message
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        self.error = try container.decodeIfPresent(String.self, forKey: .error)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.status, forKey: .status)
        try container.encodeIfPresent(self.error, forKey: .error)
        try container.encodeIfPresent(self.message, forKey: .message)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case status
        case error
        case message
    }
}