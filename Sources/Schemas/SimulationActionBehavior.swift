import Foundation

public enum SimulationActionBehavior: Codable, Hashable, Sendable {
    /// The platform calls the action's app instead of returning a mocked result.
    case callApp(CallApp)
    /// The platform does not call the action's app and uses this result as the action's
    /// result. `response` and `errorMessage` are Handlebars templates over the action's input
    /// parameters, such as `{{parameterId}}`, rendered without HTML escaping.
    case fixedResponse(FixedResponse)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .type)
        switch discriminant {
        case "callApp":
            self = .callApp(try CallApp(from: decoder))
        case "fixedResponse":
            self = .fixedResponse(try FixedResponse(from: decoder))
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
        case .callApp(let data):
            try data.encode(to: encoder)
        case .fixedResponse(let data):
            try data.encode(to: encoder)
        }
    }

    /// The platform does not call the action's app and uses this result as the action's
    /// result. `response` and `errorMessage` are Handlebars templates over the action's input
    /// parameters, such as `{{parameterId}}`, rendered without HTML escaping.
    public struct FixedResponse: Codable, Hashable, Sendable {
        public let type: String = "fixedResponse"
        /// The action's result. This is what the agent is given, whether it succeeded or failed.
        public let response: String
        /// Structured data returned alongside the response. Must serialize to fewer than 10,000 characters of JSON; data over that limit is omitted and the response is kept.
        public let data: [String: JSONValue]?
        /// Whether the action succeeded. Defaults to SUCCESS when absent.
        public let status: ActionExecutionStatus?
        /// Why the action failed, when status is ERROR. Never given to the agent. Truncated to 2,000 characters; a blank value is treated as if it were absent.
        public let errorMessage: String?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            response: String,
            data: [String: JSONValue]? = nil,
            status: ActionExecutionStatus? = nil,
            errorMessage: String? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.response = response
            self.data = data
            self.status = status
            self.errorMessage = errorMessage
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.response = try container.decode(String.self, forKey: .response)
            self.data = try container.decodeIfPresent([String: JSONValue].self, forKey: .data)
            self.status = try container.decodeIfPresent(ActionExecutionStatus.self, forKey: .status)
            self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.response, forKey: .response)
            try container.encodeIfPresent(self.data, forKey: .data)
            try container.encodeIfPresent(self.status, forKey: .status)
            try container.encodeIfPresent(self.errorMessage, forKey: .errorMessage)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case response
            case data
            case status
            case errorMessage
        }
    }

    /// The platform calls the action's app instead of returning a mocked result.
    public struct CallApp: Codable, Hashable, Sendable {
        public let type: String = "callApp"
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            self.additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}