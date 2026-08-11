import Foundation

/// What prompts the assistant turn produced by an ask. Defaults to USER_MESSAGE when omitted.
public enum AskType: String, Codable, Hashable, CaseIterable, Sendable {
    /// The default. Respond to a message the user sent; the user's words are in `text` (required).
    case userMessage = "USER_MESSAGE"
    /// The agent opens the conversation with its own greeting, with no user input. `text` is optional here; when provided it steers the greeting. Intended as the first turn of a conversation.
    case welcome = "WELCOME"
    /// The agent proactively sends a message the user did not prompt. `text` is optional here; when provided it steers what the agent says (e.g. "tell the user to restart their machine") and is a directive to the agent, not the user's own words.
    case proactive = "PROACTIVE"
}