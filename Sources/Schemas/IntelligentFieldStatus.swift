import Foundation

/// Lifecycle state for whether this field is evaluated by workflows
public enum IntelligentFieldStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case active = "ACTIVE"
    case inactive = "INACTIVE"
    case deleted = "DELETED"
}