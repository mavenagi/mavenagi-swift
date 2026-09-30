import Foundation

/// The fields a capability search can be ordered by.
public enum CapabilitySortField: String, Codable, Hashable, CaseIterable, Sendable {
    case createdAt = "CreatedAt"
    case name = "Name"
    case type = "Type"
}