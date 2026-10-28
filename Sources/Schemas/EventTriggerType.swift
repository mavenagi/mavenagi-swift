import Foundation

public enum EventTriggerType: String, Codable, Hashable, CaseIterable, Sendable {
    /// Deprecated. Use `EVENT_CREATED` instead. Never fires for simulation conversations; an
    /// `EVENT_CREATED` trigger also fires for simulation events, with
    /// `executionContext.mode: SIMULATION`.
    case conversationCreated = "CONVERSATION_CREATED"
    /// Deprecated. Use `EVENT_CREATED` instead.
    case feedbackCreated = "FEEDBACK_CREATED"
    case inboxItemCreated = "INBOX_ITEM_CREATED"
    /// Fires for live and simulation events alike. The app is told which in
    /// `executionContext.mode`.
    case eventCreated = "EVENT_CREATED"
}