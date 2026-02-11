import Foundation

/// Operators for single string value comparisons
public enum StringComparisonOperator: String, Codable, Hashable, CaseIterable, Sendable {
    /// Equals (=)
    case eq = "EQ"
    /// Not equals (!=)
    case neq = "NEQ"
    /// String contains as substring
    case containsSubstring = "CONTAINS_SUBSTRING"
    /// String does not contain as substring, i.e., negation of CONTAINS_SUBSTRING
    case notContainsSubstring = "NOT_CONTAINS_SUBSTRING"
    /// String starts with the specified prefix
    case startsWith = "STARTS_WITH"
    /// String does not start with the specified prefix
    case notStartsWith = "NOT_STARTS_WITH"
    /// String ends with the specified suffix
    case endsWith = "ENDS_WITH"
    /// String does not end with the specified suffix
    case notEndsWith = "NOT_ENDS_WITH"
}