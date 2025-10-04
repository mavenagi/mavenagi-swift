import Foundation

public enum QualityReason: String, Codable, Hashable, CaseIterable, Sendable {
    case missingKnowledge = "MISSING_KNOWLEDGE"
    case missingUserInformation = "MISSING_USER_INFORMATION"
    case missingAction = "MISSING_ACTION"
    case needsUserClarification = "NEEDS_USER_CLARIFICATION"
    case unsupportedFormat = "UNSUPPORTED_FORMAT"
    case interrupted = "INTERRUPTED"
    case unsupportedUserBehavior = "UNSUPPORTED_USER_BEHAVIOR"
    case unknown = "UNKNOWN"
    case noBotReplies = "NO_BOT_REPLIES"
}