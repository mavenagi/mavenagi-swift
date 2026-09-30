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
    /// Deprecated. Use `USER` instead.
    case userProfile = "USER_PROFILE"
    /// A user merged across apps. `referenceId` is the agent user id (`AgentUser.id`).
    case agentUser = "AGENT_USER"
    case feedback = "FEEDBACK"
    case inboxItem = "INBOX_ITEM"
    case inboxItemFix = "INBOX_ITEM_FIX"
    case segment = "SEGMENT"
    case customer = "CUSTOMER"
    case intelligentField = "INTELLIGENT_FIELD"
    case charter = "CHARTER"
    case conversationKickoff = "CONVERSATION_KICKOFF"
    case agentVariant = "AGENT_VARIANT"
    case asset = "ASSET"
    case trafficConfig = "TRAFFIC_CONFIG"
}