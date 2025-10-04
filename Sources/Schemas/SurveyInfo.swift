import Foundation

public struct SurveyInfo: Codable, Hashable, Sendable {
    public let surveyQuestion: String?
    public let surveyAnswer: String?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        surveyQuestion: String? = nil,
        surveyAnswer: String? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.surveyQuestion = surveyQuestion
        self.surveyAnswer = surveyAnswer
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.surveyQuestion = try container.decodeIfPresent(String.self, forKey: .surveyQuestion)
        self.surveyAnswer = try container.decodeIfPresent(String.self, forKey: .surveyAnswer)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.surveyQuestion, forKey: .surveyQuestion)
        try container.encodeIfPresent(self.surveyAnswer, forKey: .surveyAnswer)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case surveyQuestion
        case surveyAnswer
    }
}