import Foundation

/// Whether an agent uses a capability, and whether it still exists. Applies to every capability
/// type.
public enum CapabilityStatus: String, Codable, Hashable, CaseIterable, Sendable {
    /// The field is evaluated, and values are computed for matching entities. Shown in Agent Designer as "Enabled" on conversation kickoffs.
    case active = "ACTIVE"
    /// The field exists but is not evaluated. This is the state a new field is created in. Shown in Agent Designer as "Disabled" on conversation kickoffs.
    case inactive = "INACTIVE"
    /// The field has been soft deleted and cannot be modified. Set by the delete endpoint
    /// rather than by a patch.
    case deleted = "DELETED"
}