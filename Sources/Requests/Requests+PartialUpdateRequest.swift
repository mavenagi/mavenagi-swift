import Foundation

extension Requests {
    public struct PartialUpdateRequest: Codable, Hashable, Sendable {
        /// Whether the trigger will be called by Maven.
        public let enabled: Bool?
        /// Narrows which events fire this trigger. Omitted leaves the current condition alone; an explicit null removes it, so the trigger fires for every event again.
        public let condition: Nullable<EventCondition>?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            enabled: Bool? = nil,
            condition: Nullable<EventCondition>? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.enabled = enabled
            self.condition = condition
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
            self.condition = try container.decodeNullableIfPresent(EventCondition.self, forKey: .condition)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encodeIfPresent(self.enabled, forKey: .enabled)
            try container.encodeNullableIfPresent(self.condition, forKey: .condition)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case enabled
            case condition
        }
    }
}