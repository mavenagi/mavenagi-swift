import Foundation

/// The lifecycle status of a charter.
/// 
/// - ACTIVE: The charter is active and will be evaluated on every round. The caller is responsible
///           for ensuring ancestor charters are also ACTIVE if the full subtree should be reachable.
/// - INACTIVE: The charter is inactive. It retains its rank among siblings and its descendants retain their statuses.
///             However, it and its descendants are skipped during runtime evaluation.
/// - DELETED: The charter has been soft deleted. Excluded from searches and cannot be modified.
///            Deleting a charter cascades to all descendants (they are also soft-deleted).
public enum CharterStatus: String, Codable, Hashable, CaseIterable, Sendable {
    /// Shown in Agent Designer as "Live".
    case active = "ACTIVE"
    /// Shown in Agent Designer as "Draft".
    case inactive = "INACTIVE"
    case deleted = "DELETED"
}