import Foundation

/// Whether a conversation is spoken or written.
public enum ConversationMode: String, Codable, Hashable, CaseIterable, Sendable {
    /// A spoken conversation — phone or realtime audio.
    case voice = "VOICE"
    /// A written conversation. The default for any conversation the platform does not identify as voice.
    case text = "TEXT"
}