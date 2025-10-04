import Foundation

public enum NumericConversationField: String, Codable, Hashable, CaseIterable, Sendable {
    case thumbsUpCount = "ThumbsUpCount"
    case thumbsDownCount = "ThumbsDownCount"
    case insertCount = "InsertCount"
    case userMessageCount = "UserMessageCount"
    case handleTime = "HandleTime"
    case firstResponseTime = "FirstResponseTime"
    case predictedNps = "PredictedNPS"
}