import Foundation

extension Requests {
    public struct IntelligentFieldPatchRequest: Codable, Hashable, Sendable {
        /// The App ID of the intelligent field to update. If not provided the ID of the calling app will be used.
        public let appId: String?
        /// The definition of the intelligent field. This text will be influential in guiding the LLM to produce the desired results. Limited to 5,000 characters.
        public let definition: String?
        /// The lifecycle state for whether this field is evaluated. Use ACTIVE to start
        /// evaluating the field and INACTIVE to stop.
        /// 
        /// Each agent has a limit on how many fields may be ACTIVE at once; activating a
        /// field beyond that limit is rejected. A field referenced by an active precondition
        /// cannot be deactivated.
        public let status: CapabilityStatus?
        /// A plain text description of the intelligent field.
        public let description: String?
        /// Updated enum options for fields that constrain the LLM to a finite set. Omit to leave unchanged. The new list must be a superset of the existing options (add-only; removals are rejected).
        public let enumOptions: [EnumOption]?
        /// The agent variant to stage this patch in. Required on an agent with versioned intelligent fields; a patch that omits it there is rejected with reason `VARIANT_REQUIRED`.
        public let variantId: EntityIdWithoutAgent?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            appId: String? = nil,
            definition: String? = nil,
            status: CapabilityStatus? = nil,
            description: String? = nil,
            enumOptions: [EnumOption]? = nil,
            variantId: EntityIdWithoutAgent? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.appId = appId
            self.definition = definition
            self.status = status
            self.description = description
            self.enumOptions = enumOptions
            self.variantId = variantId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
            self.definition = try container.decodeIfPresent(String.self, forKey: .definition)
            self.status = try container.decodeIfPresent(CapabilityStatus.self, forKey: .status)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.enumOptions = try container.decodeIfPresent([EnumOption].self, forKey: .enumOptions)
            self.variantId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .variantId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encodeIfPresent(self.appId, forKey: .appId)
            try container.encodeIfPresent(self.definition, forKey: .definition)
            try container.encodeIfPresent(self.status, forKey: .status)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.enumOptions, forKey: .enumOptions)
            try container.encodeIfPresent(self.variantId, forKey: .variantId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case appId
            case definition
            case status
            case description
            case enumOptions
            case variantId
        }
    }
}