import Foundation

public struct FeedbackInfo: Codable, Hashable, Sendable {
    /// The rating of the feedback as a ratio [0.0, 1.0]
    public let rating: Double?
    /// Whether the feedback was marked as a thumbs up
    public let thumbUp: Bool?
    /// A question and answer associated with the feedback
    public let survey: SurveyInfo?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        rating: Double? = nil,
        thumbUp: Bool? = nil,
        survey: SurveyInfo? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.rating = rating
        self.thumbUp = thumbUp
        self.survey = survey
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        self.thumbUp = try container.decodeIfPresent(Bool.self, forKey: .thumbUp)
        self.survey = try container.decodeIfPresent(SurveyInfo.self, forKey: .survey)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.rating, forKey: .rating)
        try container.encodeIfPresent(self.thumbUp, forKey: .thumbUp)
        try container.encodeIfPresent(self.survey, forKey: .survey)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case rating
        case thumbUp
        case survey
    }
}