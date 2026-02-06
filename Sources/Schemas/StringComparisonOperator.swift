import Foundation

/// Operators for single string value comparisons
public enum StringComparisonOperator: String, Codable, Hashable, CaseIterable, Sendable {
    /// Equals (=)
    case eq = "EQ"
    /// Not equals (!=)
    case neq = "NEQ"
}