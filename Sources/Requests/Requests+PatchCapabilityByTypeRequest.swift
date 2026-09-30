import Foundation

extension Requests {
    public struct PatchCapabilityByTypeRequest: Codable, Hashable, Sendable {
        /// Whether the agent uses this capability. Use ACTIVE to start and INACTIVE to stop;
        /// deleting is done through the delete endpoint, so DELETED is rejected here.
        public let status: CapabilityStatus?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            status: CapabilityStatus? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.status = status
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.status = try container.decodeIfPresent(CapabilityStatus.self, forKey: .status)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encodeIfPresent(self.status, forKey: .status)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case status
        }
    }
}