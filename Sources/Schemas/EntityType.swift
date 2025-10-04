import Foundation

public enum EntityType: String, Codable, Hashable, CaseIterable, Sendable {
    case agent = "AGENT"
    case conversation = "CONVERSATION"
    case conversationMessage = "CONVERSATION_MESSAGE"
    case knowledgeBase = "KNOWLEDGE_BASE"
    case knowledgeBaseVersion = "KNOWLEDGE_BASE_VERSION"
    case knowledgeDocument = "KNOWLEDGE_DOCUMENT"
    case action = "ACTION"
    case user = "USER"
    case event = "EVENT"
    case eventTrigger = "EVENT_TRIGGER"
    case userProfile = "USER_PROFILE"
    case feedback = "FEEDBACK"
    case inboxItem = "INBOX_ITEM"
    case inboxItemFix = "INBOX_ITEM_FIX"
    case segment = "SEGMENT"
    case customer = "CUSTOMER"
}