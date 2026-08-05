import Foundation

/// Fields used to filter conversations by billing status:
/// - ELIGIBLE_AND_BILLABLE: Billable conversations with a RESOLVED resolution status.
/// - ELIGIBLE_AND_NOT_BILLABLE: Conversations eligible for billing consideration but not currently billable. Includes ERROR, IN_PROGRESS, ESCALATED, INCOMPLETE, and NEGATIVE_FEEDBACK.
/// - INELIGIBLE: Conversations excluded from billing consideration. Includes CONTENT_SAFETY_FLAGGED, PROMPT_ATTACK_FLAGGED, HANGUP, INELIGIBLE, and UNKNOWN.
public enum BillableFilterField: String, Codable, Hashable, CaseIterable, Sendable {
    case eligibleAndBillable = "ELIGIBLE_AND_BILLABLE"
    case eligibleAndNotBillable = "ELIGIBLE_AND_NOT_BILLABLE"
    case ineligible = "INELIGIBLE"
}