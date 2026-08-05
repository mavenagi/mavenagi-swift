import Foundation

/// Which round of the conversation an action must have executed in for a ConversationExecutedActionPrecondition to be met. A round is a single bot response to the user; the current round is the bot response being generated now.
public enum ConversationRound: String, Codable, Hashable, CaseIterable, Sendable {
    /// The action has executed in any round of the conversation.
    case any = "ANY"
    /// The action has executed in the current round — the bot response being generated now.
    case current = "CURRENT"
    /// The action has executed in a round before the current round.
    case previous = "PREVIOUS"
}