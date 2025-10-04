import Foundation

public enum TriggerType: String, Codable, Hashable, CaseIterable, Sendable {
    case conversationCreated = "CONVERSATION_CREATED"
    case feedbackCreated = "FEEDBACK_CREATED"
    case inboxItemCreated = "INBOX_ITEM_CREATED"
    case eventCreated = "EVENT_CREATED"
}