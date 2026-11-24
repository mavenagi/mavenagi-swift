import Foundation

public enum ConversationPrecondition: Codable, Hashable, Sendable {
    case actionExecuted(ActionExecuted)
    case app(App)
    case conversationMode(ConversationMode)
    case conversationState(ConversationState)
    case intelligentField(IntelligentField)
    case metadata(Metadata)
    case responseConfig(ResponseConfig)
    case tags(Tags)
    case time(Time)

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
        case "time":
            self = .time(try Time(from: decoder))
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
        case .time(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Tags: Codable, Hashable, Sendable {
        public let conversationPreconditionType: String = "tags"
        /// Operator to apply to this precondition
        public let `operator`: PreconditionOperator?
        /// The tags the `operator` checks the conversation's tags against.
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
        /// The metadata key the precondition reads. Without a `fieldCondition`, a missing key fails the precondition, or meets it when `operator` is `NOT`. With a `fieldCondition`, a missing key is undetermined: it meets only `IS_UNDETERMINED`.
        public let key: String
        /// Single value for CONTAINS operator or exact match. Superseded by `fieldCondition`, which carries its own value; this field and the inherited `operator` apply only without one. Keep using it until `fieldCondition` is generally available.
        public let value: String?
        /// Multiple values for CONTAINS_ANY and CONTAINS_ALL operators. Superseded by `fieldCondition`, which carries its own values; this field and the inherited `operator` apply only without one. Keep using it until `fieldCondition` is generally available.
        public let values: [String]?
        /// A typed condition on the value stored under `key`, used instead of `operator`, `value`
        /// and `values`. On charters, segments and knowledge bases, setting it together with
        /// `operator`, `value` or a non-empty `values` is a 400.
        /// 
        /// Pick the arm by how the value is stored: `string` for a plain string, such as a prefix
        /// or suffix match, and `set` for a JSON array of strings, such as `["us-east","eu-west"]`.
        /// `numeric` and `boolean` read a value written as a number or `true`/`false`.
        /// 
        /// A missing key meets only `universal` `IS_UNDETERMINED`. Every other condition is unmet,
        /// negated ones such as `NOT_STARTS_WITH` and `NEQ` included, unlike `operator: NOT`,
        /// which a missing key meets. To also match a conversation without the key, put the
        /// condition in an `OR` group with `IS_UNDETERMINED`.
        /// 
        /// A `string` condition compares the stored text, unwrapping a JSON-quoted string first, so
        /// a JSON array or number is compared as its raw text. An empty comparison value matches
        /// every value for `STARTS_WITH`, `ENDS_WITH` and `CONTAINS_SUBSTRING`. A `numeric` or
        /// `boolean` condition is unmet when the value cannot be read as that type. A `set`
        /// condition reads a value that is not a JSON array as a one-element set, and skips `null`
        /// elements, so `[null]` is an empty set. A `numeric` `comparison` or `boolean` condition
        /// without a `value` is saved with `0` or `false`, so `{"opType": "comparison",
        /// "operator": "GT"}` means greater than 0.
        public let fieldCondition: FieldCondition?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionOperator? = nil,
            key: String,
            value: String? = nil,
            values: [String]? = nil,
            fieldCondition: FieldCondition? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.key = key
            self.value = value
            self.values = values
            self.fieldCondition = fieldCondition
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
            self.key = try container.decode(String.self, forKey: .key)
            self.value = try container.decodeIfPresent(String.self, forKey: .value)
            self.values = try container.decodeIfPresent([String].self, forKey: .values)
            self.fieldCondition = try container.decodeIfPresent(FieldCondition.self, forKey: .fieldCondition)
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
            try container.encodeIfPresent(self.fieldCondition, forKey: .fieldCondition)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case conversationPreconditionType
            case `operator`
            case key
            case value
            case values
            case fieldCondition
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
        /// The condition to evaluate against the field's value.
        public let fieldCondition: FieldCondition
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            fieldIdWithoutAgent: EntityIdWithoutAgent,
            fieldCondition: FieldCondition,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.fieldIdWithoutAgent = fieldIdWithoutAgent
            self.fieldCondition = fieldCondition
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.fieldIdWithoutAgent = try container.decode(EntityIdWithoutAgent.self, forKey: .fieldIdWithoutAgent)
            self.fieldCondition = try container.decode(FieldCondition.self, forKey: .fieldCondition)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.conversationPreconditionType, forKey: .conversationPreconditionType)
            try container.encode(self.fieldIdWithoutAgent, forKey: .fieldIdWithoutAgent)
            try container.encode(self.fieldCondition, forKey: .fieldCondition)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case conversationPreconditionType
            case fieldIdWithoutAgent
            case fieldCondition
        }
    }

    public struct Time: Codable, Hashable, Sendable {
        public let conversationPreconditionType: String = "time"
        /// Operator to apply to this precondition
        public let `operator`: PreconditionOperator?
        /// The window the current time must fall inside for the precondition to be met.
        public let window: TimeWindow
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionOperator? = nil,
            window: TimeWindow,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.window = window
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
            self.window = try container.decode(TimeWindow.self, forKey: .window)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.conversationPreconditionType, forKey: .conversationPreconditionType)
            try container.encodeIfPresent(self.operator, forKey: .operator)
            try container.encode(self.window, forKey: .window)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case conversationPreconditionType
            case `operator`
            case window
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationPreconditionType
    }
}