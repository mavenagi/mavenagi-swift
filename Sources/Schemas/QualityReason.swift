import Foundation

public enum QualityReason: String, Codable, Hashable, CaseIterable, Sendable {
    case missingKnowledge = "MISSING_KNOWLEDGE"
    /// Shown in Agent Designer as "Missing user data".
    case missingUserInformation = "MISSING_USER_INFORMATION"
    case missingAction = "MISSING_ACTION"
    case needsUserClarification = "NEEDS_USER_CLARIFICATION"
    case unsupportedFormat = "UNSUPPORTED_FORMAT"
    case interrupted = "INTERRUPTED"
    case unsupportedUserBehavior = "UNSUPPORTED_USER_BEHAVIOR"
    case unknown = "UNKNOWN"
    /// Maven did not reply in the conversation. Shown in Agent Designer as "No generated responses".
    case noBotReplies = "NO_BOT_REPLIES"
}