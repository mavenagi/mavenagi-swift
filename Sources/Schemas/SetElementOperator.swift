import Foundation

/// Operators for checking single element in a set
public enum SetElementOperator: String, Codable, Hashable, CaseIterable, Sendable {
    /// Set contains the value (∋)
    case contains = "CONTAINS"
    /// Set does not contain the value (∌)
    case notContains = "NOT_CONTAINS"
}