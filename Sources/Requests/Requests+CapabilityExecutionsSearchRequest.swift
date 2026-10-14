import Foundation

extension Requests {
    public struct CapabilityExecutionsSearchRequest: Codable, Hashable, Sendable {
        /// Page number to return, defaults to 0
        public let page: Int?
        /// The size of the page to return, defaults to 20. Max 1000.
        public let size: Int?
        /// Whether to sort descending, defaults to true
        public let sortDesc: Bool?
        /// Only return executions for these subjects: conversations, inbox items or events.
        /// Same shape as the `subjectId` on a returned execution. At most 100 ids.
        /// 
        /// Filtering by feedback is not supported and is rejected with a 400. Feedback
        /// subjects come only from deprecated `FEEDBACK_CREATED` triggers; switch those to
        /// `EVENT_CREATED` triggers, whose event subjects can be filtered on.
        public let subjectIds: [EntityId]?
        /// Only return executions of these kinds of capability. Event Triggers and
        /// Conversation Kickoffs record executions today.
        public let capabilityTypes: [CapabilityType]?
        /// Only return executions of these capabilities. Same shape as the `capabilityId` on
        /// a returned execution. At most 100 ids.
        public let capabilityIds: [EntityId]?
        /// Only return executions in these states.
        public let statuses: [CapabilityExecutionStatus]?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            page: Int? = nil,
            size: Int? = nil,
            sortDesc: Bool? = nil,
            subjectIds: [EntityId]? = nil,
            capabilityTypes: [CapabilityType]? = nil,
            capabilityIds: [EntityId]? = nil,
            statuses: [CapabilityExecutionStatus]? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.page = page
            self.size = size
            self.sortDesc = sortDesc
            self.subjectIds = subjectIds
            self.capabilityTypes = capabilityTypes
            self.capabilityIds = capabilityIds
            self.statuses = statuses
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.page = try container.decodeIfPresent(Int.self, forKey: .page)
            self.size = try container.decodeIfPresent(Int.self, forKey: .size)
            self.sortDesc = try container.decodeIfPresent(Bool.self, forKey: .sortDesc)
            self.subjectIds = try container.decodeIfPresent([EntityId].self, forKey: .subjectIds)
            self.capabilityTypes = try container.decodeIfPresent([CapabilityType].self, forKey: .capabilityTypes)
            self.capabilityIds = try container.decodeIfPresent([EntityId].self, forKey: .capabilityIds)
            self.statuses = try container.decodeIfPresent([CapabilityExecutionStatus].self, forKey: .statuses)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encodeIfPresent(self.page, forKey: .page)
            try container.encodeIfPresent(self.size, forKey: .size)
            try container.encodeIfPresent(self.sortDesc, forKey: .sortDesc)
            try container.encodeIfPresent(self.subjectIds, forKey: .subjectIds)
            try container.encodeIfPresent(self.capabilityTypes, forKey: .capabilityTypes)
            try container.encodeIfPresent(self.capabilityIds, forKey: .capabilityIds)
            try container.encodeIfPresent(self.statuses, forKey: .statuses)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case page
            case size
            case sortDesc
            case subjectIds
            case capabilityTypes
            case capabilityIds
            case statuses
        }
    }
}