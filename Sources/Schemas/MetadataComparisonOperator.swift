import Foundation

/// Operators comparing a metadata value against a single string.
/// 
/// Narrower than `StringComparisonOperator` by design. Its substring and suffix
/// operators need an unanchored scan of every value, which a metadata filter cannot
/// afford; equality and prefix are answerable straight from an index.
public enum MetadataComparisonOperator: String, Codable, Hashable, CaseIterable, Sendable {
    /// Equals (=). On a list value, any element equals.
    case eq = "EQ"
    /// Not equals (!=). On a list value, no element equals.
    case neq = "NEQ"
    /// Value starts with the specified prefix. On a list value, any element does.
    case startsWith = "STARTS_WITH"
    /// Value does not start with the specified prefix. On a list value, no element does.
    case notStartsWith = "NOT_STARTS_WITH"
}