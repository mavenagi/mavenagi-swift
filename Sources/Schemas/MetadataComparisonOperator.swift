import Foundation

/// Operators comparing a metadata value against a single string.
/// 
/// Narrower than `StringComparisonOperator` by design. Its substring and suffix
/// operators need an unanchored scan of every value, which a metadata filter cannot
/// afford; equality and prefix are answerable straight from an index.
public enum MetadataComparisonOperator: String, Codable, Hashable, CaseIterable, Sendable {
    /// Equals (=)
    case eq = "EQ"
    /// Not equals (!=)
    case neq = "NEQ"
    /// Value starts with the specified prefix
    case startsWith = "STARTS_WITH"
    /// Value does not start with the specified prefix
    case notStartsWith = "NOT_STARTS_WITH"
}