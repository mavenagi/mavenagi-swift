import Foundation

public enum BotConversationMessageType: String, Codable, Hashable, CaseIterable, Sendable {
    case botResponse = "BOT_RESPONSE"
    case botSuggestion = "BOT_SUGGESTION"
}