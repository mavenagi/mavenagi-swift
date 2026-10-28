import Foundation

extension Requests {
    public struct CapabilitiesSearchRequest: Codable, Hashable, Sendable {
        /// Page number to return, defaults to 0
        public let page: Int?
        /// The size of the page to return, defaults to 20. Max 1000.
        public let size: Int?
        /// Whether to sort descending, defaults to true
        public let sortDesc: Bool?
        /// Only return capabilities of these kinds. Omit for every kind.
        public let capabilityTypes: [CapabilityType]?
        /// Only return capabilities the agent does or does not use. Deleted capabilities are
        /// never searchable, so `DELETED` is rejected here rather than matching nothing.
        public let statuses: [CapabilityStatus]?
        /// Only return capabilities owned by these apps.
        public let appIds: [String]?
        /// Only return capabilities whose name matches this text.
        public let name: String?
        /// Only return capabilities whose description matches this text.
        public let description: String?
        /// Only return capabilities that do or do not require user interaction. Only Actions
        /// can require it, so filtering on true returns Actions alone.
        public let userInteractionRequired: Bool?
        /// The field to sort by. Defaults to when the capability was created.
        public let sortId: CapabilitySortField?
        /// The agent variant to read intelligent field versions through. Required on an agent
        /// with versioned intelligent fields unless `capabilityTypes` excludes them; a
        /// request that omits it there is rejected with reason `VARIANT_REQUIRED`. Otherwise,
        /// if omitted, the agent's only variant is used, as its snapshot has it. When a
        /// variant is named, its staged edits are included: each field is listed once, at its
        /// staged edit if it has one, and a field deleted in the variant, whether the delete is
        /// staged or already in its snapshot, is left out.
        public let variantId: EntityIdWithoutAgent?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            page: Int? = nil,
            size: Int? = nil,
            sortDesc: Bool? = nil,
            capabilityTypes: [CapabilityType]? = nil,
            statuses: [CapabilityStatus]? = nil,
            appIds: [String]? = nil,
            name: String? = nil,
            description: String? = nil,
            userInteractionRequired: Bool? = nil,
            sortId: CapabilitySortField? = nil,
            variantId: EntityIdWithoutAgent? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.page = page
            self.size = size
            self.sortDesc = sortDesc
            self.capabilityTypes = capabilityTypes
            self.statuses = statuses
            self.appIds = appIds
            self.name = name
            self.description = description
            self.userInteractionRequired = userInteractionRequired
            self.sortId = sortId
            self.variantId = variantId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.page = try container.decodeIfPresent(Int.self, forKey: .page)
            self.size = try container.decodeIfPresent(Int.self, forKey: .size)
            self.sortDesc = try container.decodeIfPresent(Bool.self, forKey: .sortDesc)
            self.capabilityTypes = try container.decodeIfPresent([CapabilityType].self, forKey: .capabilityTypes)
            self.statuses = try container.decodeIfPresent([CapabilityStatus].self, forKey: .statuses)
            self.appIds = try container.decodeIfPresent([String].self, forKey: .appIds)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.userInteractionRequired = try container.decodeIfPresent(Bool.self, forKey: .userInteractionRequired)
            self.sortId = try container.decodeIfPresent(CapabilitySortField.self, forKey: .sortId)
            self.variantId = try container.decodeIfPresent(EntityIdWithoutAgent.self, forKey: .variantId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encodeIfPresent(self.page, forKey: .page)
            try container.encodeIfPresent(self.size, forKey: .size)
            try container.encodeIfPresent(self.sortDesc, forKey: .sortDesc)
            try container.encodeIfPresent(self.capabilityTypes, forKey: .capabilityTypes)
            try container.encodeIfPresent(self.statuses, forKey: .statuses)
            try container.encodeIfPresent(self.appIds, forKey: .appIds)
            try container.encodeIfPresent(self.name, forKey: .name)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.userInteractionRequired, forKey: .userInteractionRequired)
            try container.encodeIfPresent(self.sortId, forKey: .sortId)
            try container.encodeIfPresent(self.variantId, forKey: .variantId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case page
            case size
            case sortDesc
            case capabilityTypes
            case statuses
            case appIds
            case name
            case description
            case userInteractionRequired
            case sortId
            case variantId
        }
    }
}