import Foundation

extension Requests {
    public struct CreateConversationKickoffRequest: Codable, Hashable, Sendable {
        /// ID that uniquely identifies this Conversation Kickoff. Must be unique within the
        /// calling app.
        public let kickoffId: EntityIdBase
        /// The kickoff's display name, shown to whoever manages the agent.
        public let name: String
        /// What the kickoff does, shown to whoever manages the agent.
        public let description: String?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            kickoffId: EntityIdBase,
            name: String,
            description: String? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.kickoffId = kickoffId
            self.name = name
            self.description = description
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.kickoffId = try container.decode(EntityIdBase.self, forKey: .kickoffId)
            self.name = try container.decode(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.kickoffId, forKey: .kickoffId)
            try container.encode(self.name, forKey: .name)
            try container.encodeIfPresent(self.description, forKey: .description)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case kickoffId
            case name
            case description
        }
    }
}