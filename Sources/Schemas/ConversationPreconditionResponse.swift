import Foundation

public enum ConversationPreconditionResponse: Codable, Hashable, Sendable {
    case actionExecuted(ActionExecuted)
    case app(App)
    case conversationMode(ConversationMode)
    case conversationState(ConversationState)
    case intelligentField(IntelligentField)
    case metadata(Metadata)
    case responseConfig(ResponseConfig)
    case tags(Tags)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .conversationPreconditionType)
        switch discriminant {
        case "actionExecuted":
            self = .actionExecuted(try ActionExecuted(from: decoder))
        case "app":
            self = .app(try App(from: decoder))
        case "conversationMode":
            self = .conversationMode(try ConversationMode(from: decoder))
        case "conversationState":
            self = .conversationState(try ConversationState(from: decoder))
        case "intelligentField":
            self = .intelligentField(try IntelligentField(from: decoder))
        case "metadata":
            self = .metadata(try Metadata(from: decoder))
        case "responseConfig":
            self = .responseConfig(try ResponseConfig(from: decoder))
        case "tags":
            self = .tags(try Tags(from: decoder))
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
        case .actionExecuted(let data):
            try data.encode(to: encoder)
        case .app(let data):
            try data.encode(to: encoder)
        case .conversationMode(let data):
            try data.encode(to: encoder)
        case .conversationState(let data):
            try data.encode(to: encoder)
        case .intelligentField(let data):
            try data.encode(to: encoder)
        case .metadata(let data):
            try data.encode(to: encoder)
        case .responseConfig(let data):
            try data.encode(to: encoder)
        case .tags(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Tags: Codable, Hashable, Sendable {
        public let conversationPreconditionType: String = "tags"
        /// Operator to apply to this precondition
        public let `operator`: PreconditionOperator?
        /// The tags that must be present in the conversation context for the precondition to be met
        public let tags: JSONValue
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionOperator? = nil,
            tags: JSONValue,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.tags = tags
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
            self.tags = try container.decode(JSONValue.self, forKey: .tags)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.conversationPreconditionType, forKey: .conversationPreconditionType)
            try container.encodeIfPresent(self.operator, forKey: .operator)
            try container.encode(self.tags, forKey: .tags)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case conversationPreconditionType
            case `operator`
            case tags
        }
    }

    public struct Metadata: Codable, Hashable, Sendable {
        public let conversationPreconditionType: String = "metadata"
        /// Operator to apply to this precondition
        public let `operator`: PreconditionOperator?
        /// The key that must be present in the metadata for a precondition to be met
        public let key: String
        /// Single value for CONTAINS operator or exact match
        public let value: String?
        /// Multiple values for CONTAINS_ANY and CONTAINS_ALL operators
        public let values: [String]?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionOperator? = nil,
            key: String,
            value: String? = nil,
            values: [String]? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.key = key
            self.value = value
            self.values = values
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
            self.key = try container.decode(String.self, forKey: .key)
            self.value = try container.decodeIfPresent(String.self, forKey: .value)
            self.values = try container.decodeIfPresent([String].self, forKey: .values)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.conversationPreconditionType, forKey: .conversationPreconditionType)
            try container.encodeIfPresent(self.operator, forKey: .operator)
            try container.encode(self.key, forKey: .key)
            try container.encodeIfPresent(self.value, forKey: .value)
            try container.encodeIfPresent(self.values, forKey: .values)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case conversationPreconditionType
            case `operator`
            case key
            case value
            case values
        }
    }

    public struct ActionExecuted: Codable, Hashable, Sendable {
        public let conversationPreconditionType: String = "actionExecuted"
        /// Operator to apply to this precondition
        public let `operator`: PreconditionOperator?
        /// ID of an action that must have executed in this conversation for the precondition to be met
        public let actionId: String
        /// App ID that the given actionId belongs to. If not provided, the calling appId will be used.
        public let appId: String?
        /// Restricts which round the action must have executed in. Defaults to ANY when omitted, matching an action executed in any round.
        public let conversationRound: ConversationRound?
        /// Restricts the match to executions whose returned data satisfies this condition.
        /// When omitted, any execution of the action matches regardless of what it returned.
        /// 
        /// Actions may return `{response, data}`, where `data` is a JSON object persisted
        /// alongside the response. This gates the precondition on what the action returned
        /// rather than only on whether it ran.
        /// 
        /// The precondition is met when *some* execution of the action in scope returned data
        /// satisfying this condition. An action that executed but returned no data never
        /// matches, except via `universal` `IS_UNDETERMINED`.
        public let dataCondition: ObjectCondition?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionOperator? = nil,
            actionId: String,
            appId: String? = nil,
            conversationRound: ConversationRound? = nil,
            dataCondition: ObjectCondition? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.actionId = actionId
            self.appId = appId
            self.conversationRound = conversationRound
            self.dataCondition = dataCondition
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
            self.actionId = try container.decode(String.self, forKey: .actionId)
            self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
            self.conversationRound = try container.decodeIfPresent(ConversationRound.self, forKey: .conversationRound)
            self.dataCondition = try container.decodeIfPresent(ObjectCondition.self, forKey: .dataCondition)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.conversationPreconditionType, forKey: .conversationPreconditionType)
            try container.encodeIfPresent(self.operator, forKey: .operator)
            try container.encode(self.actionId, forKey: .actionId)
            try container.encodeIfPresent(self.appId, forKey: .appId)
            try container.encodeIfPresent(self.conversationRound, forKey: .conversationRound)
            try container.encodeIfPresent(self.dataCondition, forKey: .dataCondition)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case conversationPreconditionType
            case `operator`
            case actionId
            case appId
            case conversationRound
            case dataCondition
        }
    }

    public struct ResponseConfig: Codable, Hashable, Sendable {
        public let conversationPreconditionType: String = "responseConfig"
        /// Operator to apply to this precondition
        public let `operator`: PreconditionOperator?
        public let useMarkdown: Bool?
        public let useForms: Bool?
        public let useImages: Bool?
        public let isCopilot: Bool?
        public let responseLength: ResponseLength?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionOperator? = nil,
            useMarkdown: Bool? = nil,
            useForms: Bool? = nil,
            useImages: Bool? = nil,
            isCopilot: Bool? = nil,
            responseLength: ResponseLength? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.useMarkdown = useMarkdown
            self.useForms = useForms
            self.useImages = useImages
            self.isCopilot = isCopilot
            self.responseLength = responseLength
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
            self.useMarkdown = try container.decodeIfPresent(Bool.self, forKey: .useMarkdown)
            self.useForms = try container.decodeIfPresent(Bool.self, forKey: .useForms)
            self.useImages = try container.decodeIfPresent(Bool.self, forKey: .useImages)
            self.isCopilot = try container.decodeIfPresent(Bool.self, forKey: .isCopilot)
            self.responseLength = try container.decodeIfPresent(ResponseLength.self, forKey: .responseLength)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.conversationPreconditionType, forKey: .conversationPreconditionType)
            try container.encodeIfPresent(self.operator, forKey: .operator)
            try container.encodeIfPresent(self.useMarkdown, forKey: .useMarkdown)
            try container.encodeIfPresent(self.useForms, forKey: .useForms)
            try container.encodeIfPresent(self.useImages, forKey: .useImages)
            try container.encodeIfPresent(self.isCopilot, forKey: .isCopilot)
            try container.encodeIfPresent(self.responseLength, forKey: .responseLength)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case conversationPreconditionType
            case `operator`
            case useMarkdown
            case useForms
            case useImages
            case isCopilot
            case responseLength
        }
    }

    public struct App: Codable, Hashable, Sendable {
        public let conversationPreconditionType: String = "app"
        /// Operator to apply to this precondition
        public let `operator`: PreconditionOperator?
        /// Match only conversations created by this appId
        public let appId: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionOperator? = nil,
            appId: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.appId = appId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
            self.appId = try container.decode(String.self, forKey: .appId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.conversationPreconditionType, forKey: .conversationPreconditionType)
            try container.encodeIfPresent(self.operator, forKey: .operator)
            try container.encode(self.appId, forKey: .appId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case conversationPreconditionType
            case `operator`
            case appId
        }
    }

    public struct ConversationState: Codable, Hashable, Sendable {
        public let conversationPreconditionType: String = "conversationState"
        /// Operator to apply to this precondition
        public let `operator`: PreconditionOperator?
        /// The conversation state that must be active for the precondition to be met. Combine with the NOT operator to match every state except this one (e.g. NOT + WELCOME gates on "not the welcome state").
        public let state: Api.ConversationState
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionOperator? = nil,
            state: Api.ConversationState,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.state = state
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
            self.state = try container.decode(Api.ConversationState.self, forKey: .state)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.conversationPreconditionType, forKey: .conversationPreconditionType)
            try container.encodeIfPresent(self.operator, forKey: .operator)
            try container.encode(self.state, forKey: .state)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case conversationPreconditionType
            case `operator`
            case state
        }
    }

    public struct ConversationMode: Codable, Hashable, Sendable {
        public let conversationPreconditionType: String = "conversationMode"
        /// Operator to apply to this precondition
        public let `operator`: PreconditionOperator?
        /// The mode the conversation must be running in for the precondition to be met. Omit the operator for an exact match, or set it to NOT to invert (NOT + VOICE is equivalent to TEXT). Any other operator is rejected with a 400.
        public let conversationMode: Api.ConversationMode
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionOperator? = nil,
            conversationMode: Api.ConversationMode,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.conversationMode = conversationMode
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
            self.conversationMode = try container.decode(Api.ConversationMode.self, forKey: .conversationMode)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.conversationPreconditionType, forKey: .conversationPreconditionType)
            try container.encodeIfPresent(self.operator, forKey: .operator)
            try container.encode(self.conversationMode, forKey: .conversationMode)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case conversationPreconditionType
            case `operator`
            case conversationMode
        }
    }

    public struct IntelligentField: Codable, Hashable, Sendable {
        public let conversationPreconditionType: String = "intelligentField"
        /// The ID of the intelligent field.
        public let fieldIdWithoutAgent: EntityIdWithoutAgent
        /// Human-readable display name of the intelligent field. Resolved server-side.
        public let name: String?
        /// The condition to evaluate against the field's value.
        public let fieldCondition: IntelligentFieldCondition
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            fieldIdWithoutAgent: EntityIdWithoutAgent,
            name: String? = nil,
            fieldCondition: IntelligentFieldCondition,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.fieldIdWithoutAgent = fieldIdWithoutAgent
            self.name = name
            self.fieldCondition = fieldCondition
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.fieldIdWithoutAgent = try container.decode(EntityIdWithoutAgent.self, forKey: .fieldIdWithoutAgent)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.fieldCondition = try container.decode(IntelligentFieldCondition.self, forKey: .fieldCondition)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.conversationPreconditionType, forKey: .conversationPreconditionType)
            try container.encode(self.fieldIdWithoutAgent, forKey: .fieldIdWithoutAgent)
            try container.encodeIfPresent(self.name, forKey: .name)
            try container.encode(self.fieldCondition, forKey: .fieldCondition)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case conversationPreconditionType
            case fieldIdWithoutAgent
            case name
            case fieldCondition
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationPreconditionType
    }
}