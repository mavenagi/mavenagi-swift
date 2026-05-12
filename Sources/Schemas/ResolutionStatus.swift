import Foundation

public enum ResolutionStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case unknown = "UNKNOWN"
    case error = "ERROR"
    case inProgress = "IN_PROGRESS"
    case resolved = "RESOLVED"
    case escalated = "ESCALATED"
    case negativeFeedback = "NEGATIVE_FEEDBACK"
    case contentSafetyFlagged = "CONTENT_SAFETY_FLAGGED"
    case promptAttackFlagged = "PROMPT_ATTACK_FLAGGED"
    case ineligible = "INELIGIBLE"
}