import Foundation

/// Which round of the conversation an action must have executed in for a ConversationExecutedActionPrecondition to be met. A round is one user-visible bot response, which may span several model calls as actions run. The current round is the response being generated now, so CURRENT matches an action that ran earlier in this same response.
public enum ConversationRound: String, Codable, Hashable, CaseIterable, Sendable {
    /// The action has executed in any round of the conversation.
    case any = "ANY"
    /// The action has executed in the current round — the bot response being generated now.
    case current = "CURRENT"
    /// The action has executed in a round before the current round.
    case previous = "PREVIOUS"
}