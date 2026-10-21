import Foundation

public enum SegmentStatus: String, Codable, Hashable, CaseIterable, Sendable {
    /// Shown in Agent Designer as "Live".
    case active = "ACTIVE"
    /// Shown in Agent Designer as "Draft".
    case inactive = "INACTIVE"
    case deleted = "DELETED"
}