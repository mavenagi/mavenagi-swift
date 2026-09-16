import Foundation

public enum EventTriggerType: String, Codable, Hashable, CaseIterable, Sendable {
    case conversationCreated = "CONVERSATION_CREATED"
    /// Deprecated. Use `EVENT_CREATED` instead.
    case feedbackCreated = "FEEDBACK_CREATED"
    case inboxItemCreated = "INBOX_ITEM_CREATED"
    case eventCreated = "EVENT_CREATED"
}