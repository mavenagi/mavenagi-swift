import Foundation

/// Which kind of capability an entity is, and the path segment that addresses it.
public enum CapabilityType: String, Codable, Hashable, CaseIterable, Sendable {
    case action = "ACTION"
    case trigger = "TRIGGER"
    case intelligentField = "INTELLIGENT_FIELD"
    case conversationKickoff = "CONVERSATION_KICKOFF"
}