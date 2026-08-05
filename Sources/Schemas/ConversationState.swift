import Foundation

public enum ConversationState: String, Codable, Hashable, CaseIterable, Sendable {
    /// The welcome state — the very first round of the conversation, before the bot has sent a message to the user.
    case welcome = "WELCOME"
}