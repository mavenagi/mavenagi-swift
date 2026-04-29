import Foundation

/// Comparison operators for intelligent field filtering.
public enum IntelligentFieldOperator: String, Codable, Hashable, CaseIterable, Sendable {
    case eq = "EQ"
    case neq = "NEQ"
    case contains = "CONTAINS"
    case gt = "GT"
    case gte = "GTE"
    case lt = "LT"
    case lte = "LTE"
    case exists = "EXISTS"
    case notExists = "NOT_EXISTS"
}