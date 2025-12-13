import Foundation

public struct ResponseConfig: Codable, Hashable, Sendable {
    /// List of capabilities supported by the caller. Defaults to `[MARKDOWN, FORMS, IMAGES]`.
    /// 
    /// - `MARKDOWN`: Whether the response should include markdown formatting. If not provided, the response will be plain text. Not respected while streaming.
    /// - `FORMS`: Whether the response should include forms. If provided, the caller needs to render action forms when returned from the ask API and allow submission of the forms with the submitActionForm API. If not provided, then actions which require user interaction will not be considered by the LLM. Removing this capability is recommended for surfaces which can not display UI (e.g. SMS, voice).
    /// - `IMAGES`: Whether the response should include images. Not yet supported.
    /// - `CHARTS_HIGHCHARTS_TS`: Whether the response should include a Highcharts typescript chart if applicable.
    /// - `ASYNC`: Whether the app that created this conversation supports asynchronous message delivery. If provided, messages may be sent to the app via the `handleMessage` function.
    /// - `OAUTH_BUTTONS`: Whether the response should include OAuth buttons. If provided, the caller needs to render OAuth buttons when returned from the ask API and allow the user to click the buttons to initiate the OAuth flow. If not provided, then actions which require OAuth authorization will not be considered by the LLM. This capability is not recommended for surfaces which can not display links (e.g. voice).
    public let capabilities: [Capability]
    /// Whether the response is for an human agent (true) or an end user (false). Defaults to false.
    public let isCopilot: Bool
    /// The desired response length. Defaults to ResponseLength.MEDIUM.
    public let responseLength: ResponseLength
    /// Filters that restrict the knowledge retrieval candidate pool.
    /// - entities: specific entities to scope by
    /// - entityTypes: entity types to scope by (e.g., AGENT, CUSTOMER)
    public let contextFilter: KnowledgeContextFilter?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        capabilities: [Capability],
        isCopilot: Bool,
        responseLength: ResponseLength,
        contextFilter: KnowledgeContextFilter? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.capabilities = capabilities
        self.isCopilot = isCopilot
        self.responseLength = responseLength
        self.contextFilter = contextFilter
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.capabilities = try container.decode([Capability].self, forKey: .capabilities)
        self.isCopilot = try container.decode(Bool.self, forKey: .isCopilot)
        self.responseLength = try container.decode(ResponseLength.self, forKey: .responseLength)
        self.contextFilter = try container.decodeIfPresent(KnowledgeContextFilter.self, forKey: .contextFilter)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.capabilities, forKey: .capabilities)
        try container.encode(self.isCopilot, forKey: .isCopilot)
        try container.encode(self.responseLength, forKey: .responseLength)
        try container.encodeIfPresent(self.contextFilter, forKey: .contextFilter)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case capabilities
        case isCopilot
        case responseLength
        case contextFilter
    }
}