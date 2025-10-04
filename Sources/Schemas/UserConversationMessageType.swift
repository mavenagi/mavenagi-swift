import Foundation

/// The type of user message
public enum UserConversationMessageType: String, Codable, Hashable, CaseIterable, Sendable {
    case user = "USER"
    case humanAgent = "HUMAN_AGENT"
    case externalSystem = "EXTERNAL_SYSTEM"
}