import Foundation

public enum ConversationPrecondition: Codable, Hashable, Sendable {
    case tags(Tags)
    case metadata(Metadata)
    case actionExecuted(ActionExecuted)
    case responseConfig(ResponseConfig)
    case app(App)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .conversationPreconditionType)
        switch discriminant {
        case "tags":
            self = .tags(try Tags(from: decoder))
        case "metadata":
            self = .metadata(try Metadata(from: decoder))
        case "actionExecuted":
            self = .actionExecuted(try ActionExecuted(from: decoder))
        case "responseConfig":
            self = .responseConfig(try ResponseConfig(from: decoder))
        case "app":
            self = .app(try App(from: decoder))
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
        case .tags(let data):
            try data.encode(to: encoder)
        case .metadata(let data):
            try data.encode(to: encoder)
        case .actionExecuted(let data):
            try data.encode(to: encoder)
        case .responseConfig(let data):
            try data.encode(to: encoder)
        case .app(let data):
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
        /// If set, the value must match the metadata value for the given key
        public let value: String?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionOperator? = nil,
            key: String,
            value: String? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.key = key
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
            self.key = try container.decode(String.self, forKey: .key)
            self.value = try container.decodeIfPresent(String.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.conversationPreconditionType, forKey: .conversationPreconditionType)
            try container.encodeIfPresent(self.operator, forKey: .operator)
            try container.encode(self.key, forKey: .key)
            try container.encodeIfPresent(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case conversationPreconditionType
            case `operator`
            case key
            case value
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
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            operator: PreconditionOperator? = nil,
            actionId: String,
            appId: String? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.operator = `operator`
            self.actionId = actionId
            self.appId = appId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.operator = try container.decodeIfPresent(PreconditionOperator.self, forKey: .operator)
            self.actionId = try container.decode(String.self, forKey: .actionId)
            self.appId = try container.decodeIfPresent(String.self, forKey: .appId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.conversationPreconditionType, forKey: .conversationPreconditionType)
            try container.encodeIfPresent(self.operator, forKey: .operator)
            try container.encode(self.actionId, forKey: .actionId)
            try container.encodeIfPresent(self.appId, forKey: .appId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case conversationPreconditionType
            case `operator`
            case actionId
            case appId
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

    enum CodingKeys: String, CodingKey, CaseIterable {
        case conversationPreconditionType
    }
}