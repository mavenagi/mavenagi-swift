import Foundation

public struct ConversationAnalysis: Codable, Hashable, Sendable {
    /// Generated user request summary of the conversation
    public let userRequest: String?
    /// Generated agent response summary of the conversation
    public let agentResponse: String?
    /// Generated resolution status of the conversation
    public let resolutionStatus: String?
    /// Generated category of the conversation
    public let category: String?
    /// Generated sentiment of the conversation
    public let sentiment: Sentiment?
    /// Generated quality of the conversation
    public let quality: Quality?
    /// If the quality of the conversation is `UNKNOWN` or `NEEDS_IMPROVEMENT` then a reason for the quality will be provided when possible.
    public let qualityReason: QualityReason?
    /// Whether the conversation was resolved by Maven
    public let resolvedByMaven: Bool?
    /// Primary language of the conversation in ISO 639-1 code format
    public let primaryLanguage: String?
    /// The predicted NPS of the conversation.
    public let predictedNps: Double?
    /// The CSAT of the conversation.
    public let csat: Double?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        userRequest: String? = nil,
        agentResponse: String? = nil,
        resolutionStatus: String? = nil,
        category: String? = nil,
        sentiment: Sentiment? = nil,
        quality: Quality? = nil,
        qualityReason: QualityReason? = nil,
        resolvedByMaven: Bool? = nil,
        primaryLanguage: String? = nil,
        predictedNps: Double? = nil,
        csat: Double? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.userRequest = userRequest
        self.agentResponse = agentResponse
        self.resolutionStatus = resolutionStatus
        self.category = category
        self.sentiment = sentiment
        self.quality = quality
        self.qualityReason = qualityReason
        self.resolvedByMaven = resolvedByMaven
        self.primaryLanguage = primaryLanguage
        self.predictedNps = predictedNps
        self.csat = csat
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userRequest = try container.decodeIfPresent(String.self, forKey: .userRequest)
        self.agentResponse = try container.decodeIfPresent(String.self, forKey: .agentResponse)
        self.resolutionStatus = try container.decodeIfPresent(String.self, forKey: .resolutionStatus)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.sentiment = try container.decodeIfPresent(Sentiment.self, forKey: .sentiment)
        self.quality = try container.decodeIfPresent(Quality.self, forKey: .quality)
        self.qualityReason = try container.decodeIfPresent(QualityReason.self, forKey: .qualityReason)
        self.resolvedByMaven = try container.decodeIfPresent(Bool.self, forKey: .resolvedByMaven)
        self.primaryLanguage = try container.decodeIfPresent(String.self, forKey: .primaryLanguage)
        self.predictedNps = try container.decodeIfPresent(Double.self, forKey: .predictedNps)
        self.csat = try container.decodeIfPresent(Double.self, forKey: .csat)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.userRequest, forKey: .userRequest)
        try container.encodeIfPresent(self.agentResponse, forKey: .agentResponse)
        try container.encodeIfPresent(self.resolutionStatus, forKey: .resolutionStatus)
        try container.encodeIfPresent(self.category, forKey: .category)
        try container.encodeIfPresent(self.sentiment, forKey: .sentiment)
        try container.encodeIfPresent(self.quality, forKey: .quality)
        try container.encodeIfPresent(self.qualityReason, forKey: .qualityReason)
        try container.encodeIfPresent(self.resolvedByMaven, forKey: .resolvedByMaven)
        try container.encodeIfPresent(self.primaryLanguage, forKey: .primaryLanguage)
        try container.encodeIfPresent(self.predictedNps, forKey: .predictedNps)
        try container.encodeIfPresent(self.csat, forKey: .csat)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case userRequest
        case agentResponse
        case resolutionStatus
        case category
        case sentiment
        case quality
        case qualityReason
        case resolvedByMaven
        case primaryLanguage
        case predictedNps
        case csat
    }
}