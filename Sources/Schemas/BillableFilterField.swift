import Foundation

/// Fields used to filter conversations by billing status:
/// - ELIGIBLE_AND_BILLABLE: Billable conversations with a RESOLVED resolution status. Shown in Agent Designer as "Billable".
/// - ELIGIBLE_AND_NOT_BILLABLE: Eligible conversations that are not RESOLVED. Shown in Agent Designer as "Not billable". Includes ERROR, IN_PROGRESS, ESCALATED, INCOMPLETE, and NEGATIVE_FEEDBACK.
/// - INELIGIBLE: Conversations excluded from billing consideration. Includes CONTENT_SAFETY_FLAGGED, PROMPT_ATTACK_FLAGGED, HANGUP, INELIGIBLE, and UNKNOWN. Shown in Agent Designer as "Not eligible". This differs from the INELIGIBLE resolution status, which covers copilot chat conversations only.
/// 
/// Resolution-based pricing bills ELIGIBLE_AND_BILLABLE conversations. Volume-based pricing, used
/// for Voice and Proactive, bills ELIGIBLE_AND_BILLABLE and ELIGIBLE_AND_NOT_BILLABLE conversations.
/// Resolution rate is ELIGIBLE_AND_BILLABLE divided by both eligible values. Simulator and test
/// suite conversations are never billed. See [Resolution status and billing](https://docs.mavenagi.com/agent-designer/pages/resolution-status).
public enum BillableFilterField: String, Codable, Hashable, CaseIterable, Sendable {
    case eligibleAndBillable = "ELIGIBLE_AND_BILLABLE"
    case eligibleAndNotBillable = "ELIGIBLE_AND_NOT_BILLABLE"
    case ineligible = "INELIGIBLE"
}