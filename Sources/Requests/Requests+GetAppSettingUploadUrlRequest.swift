import Foundation

extension Requests {
    public struct GetAppSettingUploadUrlRequest: Codable, Hashable, Sendable {
        public let contentLength: Int
        public let contentType: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            contentLength: Int,
            contentType: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.contentLength = contentLength
            self.contentType = contentType
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.contentLength = try container.decode(Int.self, forKey: .contentLength)
            self.contentType = try container.decode(String.self, forKey: .contentType)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.contentLength, forKey: .contentLength)
            try container.encode(self.contentType, forKey: .contentType)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case contentLength
            case contentType
        }
    }
}