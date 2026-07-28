import Foundation

/// Type-independent operators that check whether an intelligent field has a
/// determined value on the conversation, rather than comparing its value.
public enum PresenceOperator: String, Codable, Hashable, CaseIterable, Sendable {
    /// The field has no determined value — the LLM could not determine one, the
    /// computation failed, is still running, or has not run. Surfaced to authors as
    /// the special "Undetermined" value.
    case isUndetermined = "IS_UNDETERMINED"
    /// The field has a determined (non-null) value.
    case isDetermined = "IS_DETERMINED"
}