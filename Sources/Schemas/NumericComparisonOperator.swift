import Foundation

/// Operators for single numeric value comparisons
public enum NumericComparisonOperator: String, Codable, Hashable, CaseIterable, Sendable {
    /// Equals (=)
    case eq = "EQ"
    /// Not equals (!=)
    case neq = "NEQ"
    /// Less than (<)
    case lt = "LT"
    /// Less than or equals (<=)
    case le = "LE"
    /// Greater than (>)
    case gt = "GT"
    /// Greater than or equals (>=)
    case ge = "GE"
}