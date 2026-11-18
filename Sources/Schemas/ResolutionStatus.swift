import Foundation

/// The outcome of a conversation. Shown in Agent Designer as "Resolution status".
/// 
/// The status is recalculated whenever the conversation changes, such as a new message,
/// feedback, a CSAT rating or an insert. The conditions are checked in this order, and the
/// first one that matches sets the status: `INELIGIBLE`, `CONTENT_SAFETY_FLAGGED`,
/// `PROMPT_ATTACK_FLAGGED`, `HANGUP`, `IN_PROGRESS`, `ERROR`, `NEGATIVE_FEEDBACK`, `ESCALATED`,
/// then `RESOLVED`.
/// 
/// Code applies these checks, except for one input: the AI summary of the transcript can report
/// a handoff, which sets `ESCALATED`.
/// 
/// Each status maps to one billing status (`BillableFilterField`): `RESOLVED` is billable;
/// `ESCALATED`, `NEGATIVE_FEEDBACK`, `ERROR`, `IN_PROGRESS` and `INCOMPLETE` are not billable;
/// the others are not eligible. These are labels. Volume-based pricing also bills not billable
/// conversations. See
/// [Resolution status and billing](https://docs.mavenagi.com/agent-designer/pages/resolution-status).
public enum ResolutionStatus: String, Codable, Hashable, CaseIterable, Sendable {
    /// Reserved. Not assigned to conversations today. Billing status: not eligible. Shown in
    /// Agent Designer as "Unknown".
    case unknown = "UNKNOWN"
    /// The agent returned an empty response to a message. Billing status: not billable. Shown
    /// in Agent Designer as "Error".
    case error = "ERROR"
    /// The agent has not responded yet. Billing status: not billable. Shown in Agent Designer
    /// as "In progress".
    case inProgress = "IN_PROGRESS"
    /// The agent responded and no other status applies. Billing status: billable, the only
    /// status that is. `resolvedByMaven` is `true` exactly when the status is `RESOLVED`. Shown
    /// in Agent Designer as "Resolved by Maven".
    case resolved = "RESOLVED"
    /// The conversation was handed off to a human agent. Either an AI analysis of the
    /// transcript found a handoff, or a handoff action that Maven recognizes ran successfully.
    /// The AI analysis can be wrong. Once escalation is detected, later messages do not undo
    /// it, but the earlier checks, such as `NEGATIVE_FEEDBACK`, still take precedence. Copilot
    /// conversations are never `ESCALATED`. Billing status: not billable. Shown in Agent
    /// Designer as "Escalated".
    case escalated = "ESCALATED"
    /// Reserved. Not assigned to conversations today. Billing status: not billable. Shown in
    /// Agent Designer as "Incomplete".
    case incomplete = "INCOMPLETE"
    /// The end user or a human agent gave a thumbs down, or the average CSAT is below 50% of
    /// the maximum rating. An insert of an agent response overrides a thumbs down. Billing
    /// status: not billable. Shown in Agent Designer as "Negative feedback".
    case negativeFeedback = "NEGATIVE_FEEDBACK"
    /// A message was flagged by content safety guardrails. Billing status: not eligible. Shown
    /// in Agent Designer as "Content safety flagged".
    case contentSafetyFlagged = "CONTENT_SAFETY_FLAGGED"
    /// A message was flagged as a prompt injection attack. Billing status: not eligible. Shown
    /// in Agent Designer as "Prompt attack flagged".
    case promptAttackFlagged = "PROMPT_ATTACK_FLAGGED"
    /// A voice call of 5 seconds or less, measured from the first message to the last. Billing
    /// status: not eligible. Shown in Agent Designer as "Hangup".
    case hangup = "HANGUP"
    /// A copilot chat conversation. Billing status: not eligible. Shown in Agent Designer as
    /// "Ineligible". Not the same as the `INELIGIBLE` billing status, which covers every not
    /// eligible status.
    case ineligible = "INELIGIBLE"
}