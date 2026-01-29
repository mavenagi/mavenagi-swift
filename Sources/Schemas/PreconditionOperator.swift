import Foundation

public enum PreconditionOperator: String, Codable, Hashable, CaseIterable, Sendable {
    /// Negation operator (can compose with any comparison operator)
    case not = "NOT"
    /// Single value - check if value is in JSON array (x ∈ array)
    case contains = "CONTAINS"
    /// Single value - check if value is NOT in JSON array (x ∉ array)
    case notContains = "NOT_CONTAINS"
    /// Multiple values - check if ANY value is in JSON array ({x,y} ∩ array ≠ ∅)
    case containsAny = "CONTAINS_ANY"
    /// Multiple values - check if NO values are in JSON array ({x,y} ∩ array = ∅)
    case notContainsAny = "NOT_CONTAINS_ANY"
    /// Multiple values - check if ALL values are in JSON array ({x,y} ⊆ array)
    case containsAll = "CONTAINS_ALL"
    /// Multiple values - check if NOT ALL values are in JSON array ({x,y} ⊄ array)
    case notContainsAll = "NOT_CONTAINS_ALL"
}