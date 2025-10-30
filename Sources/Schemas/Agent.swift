import Foundation

public struct Agent: Codable, Hashable, Sendable {
    /// ID that uniquely identifies this action
    public let agentId: EntityId
    /// The name of the agent.
    public let name: String
    /// When the agent was created.
    public let createdAt: Date
    /// The environment of the agent. Default is `DEMO`.
    public let environment: AgentEnvironment
    /// The agent's default timezone. This is used when a timezone is not set on a conversation.
    public let defaultTimezone: String
    /// The PII categories that are enabled for the agent. 
    /// PII will be automatically redacted from all conversation message text. 
    /// Attachments and form submissions are not affected. 
    /// 
    /// Defaults to `AbaRoutingNumber`, `CreditCardNumber`, `IpAddress`, `PhoneNumber`, `SwiftCode`, 
    /// `UsBankAccountNumber`, `UsDriversLicenseNumber`, `UsIndividualTaxpayerIdentification`,
    /// `UsUkPassportNumber`, `UsSocialSecurityNumber`.
    public let enabledPiiCategories: JSONValue
    /// Text shown to end users when the system encounters an error while generating a bot response message.
    /// 
    /// This text is also used when a content safety violation is detected, unless `contentSafetyViolationPromptText` is set.
    public let systemFallbackMessage: String?
    /// Agent prompting settings.
    public let prompting: AgentPrompting
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        agentId: EntityId,
        name: String,
        createdAt: Date,
        environment: AgentEnvironment,
        defaultTimezone: String,
        enabledPiiCategories: JSONValue,
        systemFallbackMessage: String? = nil,
        prompting: AgentPrompting,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.agentId = agentId
        self.name = name
        self.createdAt = createdAt
        self.environment = environment
        self.defaultTimezone = defaultTimezone
        self.enabledPiiCategories = enabledPiiCategories
        self.systemFallbackMessage = systemFallbackMessage
        self.prompting = prompting
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.agentId = try container.decode(EntityId.self, forKey: .agentId)
        self.name = try container.decode(String.self, forKey: .name)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.environment = try container.decode(AgentEnvironment.self, forKey: .environment)
        self.defaultTimezone = try container.decode(String.self, forKey: .defaultTimezone)
        self.enabledPiiCategories = try container.decode(JSONValue.self, forKey: .enabledPiiCategories)
        self.systemFallbackMessage = try container.decodeIfPresent(String.self, forKey: .systemFallbackMessage)
        self.prompting = try container.decode(AgentPrompting.self, forKey: .prompting)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.agentId, forKey: .agentId)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.environment, forKey: .environment)
        try container.encode(self.defaultTimezone, forKey: .defaultTimezone)
        try container.encode(self.enabledPiiCategories, forKey: .enabledPiiCategories)
        try container.encodeIfPresent(self.systemFallbackMessage, forKey: .systemFallbackMessage)
        try container.encode(self.prompting, forKey: .prompting)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case agentId
        case name
        case createdAt
        case environment
        case defaultTimezone
        case enabledPiiCategories
        case systemFallbackMessage
        case prompting
    }
}