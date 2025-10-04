import Foundation

public enum InboxItemStatus: String, Codable, Hashable, CaseIterable, Sendable {
    /// The inbox item is open.
    case open = "OPEN"
    /// The inbox item was resolved by the user.
    case userResolved = "USER_RESOLVED"
    /// The inbox item was resolved by the system.
    case systemResolved = "SYSTEM_RESOLVED"
    /// The inbox item has regressed.
    case regressed = "REGRESSED"
    /// The inbox item was ignored.
    case ignored = "IGNORED"
}