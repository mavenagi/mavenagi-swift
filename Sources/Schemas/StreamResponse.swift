import Foundation

public enum StreamResponse: Codable, Hashable, Sendable {
    case text(Text)
    case action(Action)
    case oauthButton(OauthButton)
    case chart(Chart)
    case metadata(Metadata)
    case start(Start)
    case end(End)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .eventType)
        switch discriminant {
        case "text":
            self = .text(try Text(from: decoder))
        case "action":
            self = .action(try Action(from: decoder))
        case "oauthButton":
            self = .oauthButton(try OauthButton(from: decoder))
        case "chart":
            self = .chart(try Chart(from: decoder))
        case "metadata":
            self = .metadata(try Metadata(from: decoder))
        case "start":
            self = .start(try Start(from: decoder))
        case "end":
            self = .end(try End(from: decoder))
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
        case .text(let data):
            try data.encode(to: encoder)
        case .action(let data):
            try data.encode(to: encoder)
        case .oauthButton(let data):
            try data.encode(to: encoder)
        case .chart(let data):
            try data.encode(to: encoder)
        case .metadata(let data):
            try data.encode(to: encoder)
        case .start(let data):
            try data.encode(to: encoder)
        case .end(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Text: Codable, Hashable, Sendable {
        public let eventType: String = "text"
        /// A partial response to the question. All stream text events should be concatenated to form the full response.
        public let contents: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            contents: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.contents = contents
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.contents = try container.decode(String.self, forKey: .contents)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventType, forKey: .eventType)
            try container.encode(self.contents, forKey: .contents)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventType
            case contents
        }
    }

    public struct Action: Codable, Hashable, Sendable {
        public let eventType: String = "action"
        /// The ID to use when submitting the form via the `submitActionForm` API.
        public let id: String
        /// The ID of the action that will be executed when the form is submitted.
        public let actionId: EntityIdWithoutAgent
        /// Text which should be displayed to the user at the top of the form. Provided in the user's language.
        public let formLabel: String
        /// The fields that should be displayed within the form.
        public let fields: [ActionFormField]
        /// Text that should be displayed to the user on the submit button. Provided in the user's language.
        public let submitLabel: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            id: String,
            actionId: EntityIdWithoutAgent,
            formLabel: String,
            fields: [ActionFormField],
            submitLabel: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.id = id
            self.actionId = actionId
            self.formLabel = formLabel
            self.fields = fields
            self.submitLabel = submitLabel
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.actionId = try container.decode(EntityIdWithoutAgent.self, forKey: .actionId)
            self.formLabel = try container.decode(String.self, forKey: .formLabel)
            self.fields = try container.decode([ActionFormField].self, forKey: .fields)
            self.submitLabel = try container.decode(String.self, forKey: .submitLabel)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventType, forKey: .eventType)
            try container.encode(self.id, forKey: .id)
            try container.encode(self.actionId, forKey: .actionId)
            try container.encode(self.formLabel, forKey: .formLabel)
            try container.encode(self.fields, forKey: .fields)
            try container.encode(self.submitLabel, forKey: .submitLabel)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventType
            case id
            case actionId
            case formLabel
            case fields
            case submitLabel
        }
    }

    public struct OauthButton: Codable, Hashable, Sendable {
        public let eventType: String = "oauthButton"
        /// Text that should be displayed to the user on the button.
        public let buttonName: String
        /// The OAuth authorization URL to open when the button is clicked. Will only be provided on ask responses.
        public let url: String?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            buttonName: String,
            url: String? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.buttonName = buttonName
            self.url = url
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.buttonName = try container.decode(String.self, forKey: .buttonName)
            self.url = try container.decodeIfPresent(String.self, forKey: .url)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventType, forKey: .eventType)
            try container.encode(self.buttonName, forKey: .buttonName)
            try container.encodeIfPresent(self.url, forKey: .url)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventType
            case buttonName
            case url
        }
    }

    public struct Chart: Codable, Hashable, Sendable {
        public let eventType: String = "chart"
        /// The label of the chart
        public let label: String
        public let specSchema: ChartSpecSchema
        /// The spec string for the chart. For HIGHCHARTS_TS charts, the spec is the json object that represents the chart options.
        public let spec: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            label: String,
            specSchema: ChartSpecSchema,
            spec: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.label = label
            self.specSchema = specSchema
            self.spec = spec
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.label = try container.decode(String.self, forKey: .label)
            self.specSchema = try container.decode(ChartSpecSchema.self, forKey: .specSchema)
            self.spec = try container.decode(String.self, forKey: .spec)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventType, forKey: .eventType)
            try container.encode(self.label, forKey: .label)
            try container.encode(self.specSchema, forKey: .specSchema)
            try container.encode(self.spec, forKey: .spec)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventType
            case label
            case specSchema
            case spec
        }
    }

    public struct Metadata: Codable, Hashable, Sendable {
        public let eventType: String = "metadata"
        public let followupQuestions: [String]
        public let sources: [Source]
        /// The language of the message in ISO 639-1 code format
        public let language: String?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            followupQuestions: [String],
            sources: [Source],
            language: String? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.followupQuestions = followupQuestions
            self.sources = sources
            self.language = language
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.followupQuestions = try container.decode([String].self, forKey: .followupQuestions)
            self.sources = try container.decode([Source].self, forKey: .sources)
            self.language = try container.decodeIfPresent(String.self, forKey: .language)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventType, forKey: .eventType)
            try container.encode(self.followupQuestions, forKey: .followupQuestions)
            try container.encode(self.sources, forKey: .sources)
            try container.encodeIfPresent(self.language, forKey: .language)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventType
            case followupQuestions
            case sources
            case language
        }
    }

    public struct Start: Codable, Hashable, Sendable {
        public let eventType: String = "start"
        public let conversationMessageId: EntityId
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            conversationMessageId: EntityId,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.conversationMessageId = conversationMessageId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.conversationMessageId = try container.decode(EntityId.self, forKey: .conversationMessageId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventType, forKey: .eventType)
            try container.encode(self.conversationMessageId, forKey: .conversationMessageId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventType
            case conversationMessageId
        }
    }

    public struct End: Codable, Hashable, Sendable {
        public let eventType: String = "end"
        public let error: ErrorMessage?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            error: ErrorMessage? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.error = error
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.error = try container.decodeIfPresent(ErrorMessage.self, forKey: .error)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.eventType, forKey: .eventType)
            try container.encodeIfPresent(self.error, forKey: .error)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case eventType
            case error
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case eventType
    }
}