import Foundation

public enum BotResponse: Codable, Hashable, Sendable {
    case actionForm(ActionForm)
    case chart(Chart)
    case oauthButton(OauthButton)
    case object(Object)
    case text(Text)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .type)
        switch discriminant {
        case "actionForm":
            self = .actionForm(try ActionForm(from: decoder))
        case "chart":
            self = .chart(try Chart(from: decoder))
        case "oauthButton":
            self = .oauthButton(try OauthButton(from: decoder))
        case "object":
            self = .object(try Object(from: decoder))
        case "text":
            self = .text(try Text(from: decoder))
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
        case .actionForm(let data):
            try data.encode(to: encoder)
        case .chart(let data):
            try data.encode(to: encoder)
        case .oauthButton(let data):
            try data.encode(to: encoder)
        case .object(let data):
            try data.encode(to: encoder)
        case .text(let data):
            try data.encode(to: encoder)
        }
    }

    public struct Text: Codable, Hashable, Sendable {
        public let type: String = "text"
        public let text: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            text: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.text = text
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.text = try container.decode(String.self, forKey: .text)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.text, forKey: .text)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case text
        }
    }

    public struct ActionForm: Codable, Hashable, Sendable {
        public let type: String = "actionForm"
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
            try container.encode(self.type, forKey: .type)
            try container.encode(self.id, forKey: .id)
            try container.encode(self.actionId, forKey: .actionId)
            try container.encode(self.formLabel, forKey: .formLabel)
            try container.encode(self.fields, forKey: .fields)
            try container.encode(self.submitLabel, forKey: .submitLabel)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case id
            case actionId
            case formLabel
            case fields
            case submitLabel
        }
    }

    public struct OauthButton: Codable, Hashable, Sendable {
        public let type: String = "oauthButton"
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
            try container.encode(self.type, forKey: .type)
            try container.encode(self.buttonName, forKey: .buttonName)
            try container.encodeIfPresent(self.url, forKey: .url)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case buttonName
            case url
        }
    }

    public struct Chart: Codable, Hashable, Sendable {
        public let type: String = "chart"
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
            try container.encode(self.type, forKey: .type)
            try container.encode(self.label, forKey: .label)
            try container.encode(self.specSchema, forKey: .specSchema)
            try container.encode(self.spec, forKey: .spec)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case label
            case specSchema
            case spec
        }
    }

    public struct Object: Codable, Hashable, Sendable {
        public let type: String = "object"
        /// A human-readable name for the generated object, for use in the UI.
        public let label: String?
        /// The generated object conforming to the provided schema.
        public let object: JSONValue
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            label: String? = nil,
            object: JSONValue,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.label = label
            self.object = object
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.label = try container.decodeIfPresent(String.self, forKey: .label)
            self.object = try container.decode(JSONValue.self, forKey: .object)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encodeIfPresent(self.label, forKey: .label)
            try container.encode(self.object, forKey: .object)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case label
            case object
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}