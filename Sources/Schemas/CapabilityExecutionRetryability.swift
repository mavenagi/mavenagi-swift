import Foundation

/// Whether running a failed execution again would be safe and worthwhile: whether the failure is
/// transient, and whether a side effect may already have happened. Only the intersection is safe
/// to retry automatically.
public enum CapabilityExecutionRetryability: String, Codable, Hashable, CaseIterable, Sendable {
    /// Transient, and running it again is safe -- the app provably never received the call, or it said so.
    case retryable = "RETRYABLE"
    /// Possibly transient, but the app may already have applied side effects.
    case unsafe = "UNSAFE"
    /// Running it again cannot succeed without a change on the app's side.
    case permanent = "PERMANENT"
}