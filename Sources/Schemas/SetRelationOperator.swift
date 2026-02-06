import Foundation

/// Operators for set relation operations
public enum SetRelationOperator: String, Codable, Hashable, CaseIterable, Sendable {
    /// Set equals the specified set (=)
    case eq = "EQ"
    /// Set does not equal the specified set (≠)
    case neq = "NEQ"
    /// Set contains any of the values (A ∩ B ≠ ∅)
    case containsAny = "CONTAINS_ANY"
    /// Set contains none of the values (A ∩ B = ∅)
    case notContainsAny = "NOT_CONTAINS_ANY"
    /// Set contains all of the values (A ⊇ B)
    case containsAll = "CONTAINS_ALL"
    /// Set does not contain all of the values (A ⊉ B)
    case notContainsAll = "NOT_CONTAINS_ALL"
    /// Set is a subset of the values (A ⊆ B)
    case subsetOf = "SUBSET_OF"
    /// Set is not a subset of the values (A ⊈ B)
    case notSubsetOf = "NOT_SUBSET_OF"
}