import Foundation

extension Requests {
    public struct InboxItemPatchRequest: Codable, Hashable, Sendable {
        /// The App ID of the inbox item to patch. If not provided the ID of the calling app will be used.
        public let appId: String?
        /// Status of the inbox item.
        public let status: InboxItemStatus?
        /// Severity of the inbox item.
        public let severity: InboxItemSeverity?
        /// Set of 16 key-value pairs that can be attached to an object. This can be useful for storing
        /// additional information about the object in a structured format, and querying for objects
        /// via API or the dashboard.
        /// 
        /// Keys are strings with a maximum length of 64 characters. Values are strings with a maximum
        /// length of 512 characters.
        public let metadata: [String: String]?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            appId: String? = nil,
            status: InboxItemStatus? = nil,
            severity: InboxItemSeverity? = nil,
            metadata: [String: String]? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.appId = appId
            self.status = status
            self.severity = severity
            self.metadata = metadata
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
            self.status = try container.decodeIfPresent(InboxItemStatus.self, forKey: .status)
            self.severity = try container.decodeIfPresent(InboxItemSeverity.self, forKey: .severity)
            self.metadata = try container.decodeIfPresent([String: String].self, forKey: .metadata)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encodeIfPresent(self.appId, forKey: .appId)
            try container.encodeIfPresent(self.status, forKey: .status)
            try container.encodeIfPresent(self.severity, forKey: .severity)
            try container.encodeIfPresent(self.metadata, forKey: .metadata)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case appId
            case status
            case severity
            case metadata
        }
    }
}