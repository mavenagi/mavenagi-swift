import Foundation

/// A predicate over an event, deciding whether an event trigger fires for it. A trigger with
/// no condition fires for every event on its agent.
/// 
/// Each condition tests one thing: `userEventName` and `systemEventName` match events of one
/// family by name, `data` matches one key of `contextInfo.additionalData`, and `references`
/// matches the entities an event references. `data` and `references` match events of either
/// family. Combine conditions with `group`.
/// 
/// A condition may nest at most 3 levels deep and hold at most 10 conditions and groups in
/// total. Exceeding either is a 400.
public indirect enum EventCondition: Codable, Hashable, Sendable {
    /// A condition on one key of `contextInfo.additionalData`. Values are compared as strings,
    /// so there is no numeric comparison.
    case data(Data)
    case group(Group)
    case references(References)
    case systemEventName(SystemEventName)
    case userEventName(UserEventName)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .eventConditionType)
        switch discriminant {
        case "data":
            self = .data(try Data(from: decoder))
        case "group":
            self = .group(try Group(from: decoder))
        case "references":
            self = .references(try References(from: decoder))
        case "systemEventName":
            self = .systemEventName(try SystemEventName(from: decoder))
        case "userEventName":
            self = .userEventName(try UserEventName(from: decoder))
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown shape discriminant value: \(discriminant)"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws -> Void {
        switch self {
        case .data(let data):
            try data.encode(to: encoder)
        case .group(let data):
            try data.encode(to: encoder)
        case .references(let data):
            try data.encode(to: encoder)
        case .systemEventName(let data):
            try data.encode(to: encoder)
        case .userEventName(let data):
            try data.encode(to: encoder)
        }
    }

    public struct UserEventName: Codable, Hashable, Sendable {
        public let eventConditionType: String = "userEventName"
        /// The membership operator to apply.
        public let `operator`: StringMembershipOperator
        /// The user event names to match, at most 50. At least one is required.
        public let names: [Api.UserEventName]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: StringMembershipOperator,
            names: [Api.UserEventName],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.names = names
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decode(StringMembershipOperator.self, forKey: .operator)
            self.names = try container.decode([Api.UserEventName].self, forKey: .names)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventConditionType, forKey: .eventConditionType)
            try container.encode(self.operator, forKey: .operator)
            try container.encode(self.names, forKey: .names)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventConditionType
            case `operator`
            case names
        }
    }

    public struct SystemEventName: Codable, Hashable, Sendable {
        public let eventConditionType: String = "systemEventName"
        /// The membership operator to apply.
        public let `operator`: StringMembershipOperator
        /// The system event names to match, at most 50. At least one is required.
        public let names: [Api.SystemEventName]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: StringMembershipOperator,
            names: [Api.SystemEventName],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.names = names
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decode(StringMembershipOperator.self, forKey: .operator)
            self.names = try container.decode([Api.SystemEventName].self, forKey: .names)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventConditionType, forKey: .eventConditionType)
            try container.encode(self.operator, forKey: .operator)
            try container.encode(self.names, forKey: .names)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventConditionType
            case `operator`
            case names
        }
    }

    /// A condition on one key of `contextInfo.additionalData`. Values are compared as strings,
    /// so there is no numeric comparison.
    public struct Data: Codable, Hashable, Sendable {
        public let eventConditionType: String = "data"
        /// The metadata key to test. A plain key, not a path: metadata is a flat string-to-string map, so there is no nesting to address.
        public let key: String
        /// The condition to evaluate against the value stored under `key`.
        public let condition: MetadataCondition
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            key: String,
            condition: MetadataCondition,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.key = key
            self.condition = condition
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.key = try container.decode(String.self, forKey: .key)
            self.condition = try container.decode(MetadataCondition.self, forKey: .condition)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventConditionType, forKey: .eventConditionType)
            try container.encode(self.key, forKey: .key)
            try container.encode(self.condition, forKey: .condition)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventConditionType
            case key
            case condition
        }
    }

    public struct References: Codable, Hashable, Sendable {
        public let eventConditionType: String = "references"
        /// The set relation to apply. The event's references are the left-hand set.
        public let `operator`: SetRelationOperator
        /// The entities to match, at most 50. A conversation message is identified by its conversation, so give the conversation as `scopeEntityId` when naming one. An event that references a message also references its conversation, so `EQ` and `SUBSET_OF` must name both.
        public let references: [ScopedEntity]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: SetRelationOperator,
            references: [ScopedEntity],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.references = references
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decode(SetRelationOperator.self, forKey: .operator)
            self.references = try container.decode([ScopedEntity].self, forKey: .references)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventConditionType, forKey: .eventConditionType)
            try container.encode(self.operator, forKey: .operator)
            try container.encode(self.references, forKey: .references)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventConditionType
            case `operator`
            case references
        }
    }

    public struct Group: Codable, Hashable, Sendable {
        public let eventConditionType: String = "group"
        /// How to combine `conditions`.
        public let `operator`: PreconditionGroupOperator
        /// The conditions to combine. At least one is required; to match every event, omit the trigger's condition entirely.
        public let conditions: [EventCondition]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionGroupOperator,
            conditions: [EventCondition],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.conditions = conditions
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decode(PreconditionGroupOperator.self, forKey: .operator)
            self.conditions = try container.decode([EventCondition].self, forKey: .conditions)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventConditionType, forKey: .eventConditionType)
            try container.encode(self.operator, forKey: .operator)
            try container.encode(self.conditions, forKey: .conditions)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventConditionType
            case `operator`
            case conditions
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case eventConditionType
    }
}