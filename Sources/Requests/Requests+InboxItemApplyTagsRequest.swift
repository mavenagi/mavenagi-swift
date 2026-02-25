import Foundation

extension Requests {
    public struct InboxItemApplyTagsRequest: Codable, Hashable, Sendable {
        /// The App ID of a custom inbox item to patch tags for. For server-managed inbox items such as Missing Knowledge and Duplicate Documents, the appId field is not required and will be ignored.
        public let appId: String?
        /// A set of tags associated with the inbox item that are used for filtering.
        public let tags: JSONValue
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            appId: String? = nil,
            tags: JSONValue,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.appId = appId
            self.tags = tags
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
            self.tags = try container.decode(JSONValue.self, forKey: .tags)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encodeIfPresent(self.appId, forKey: .appId)
            try container.encode(self.tags, forKey: .tags)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case appId
            case tags
        }
    }
}