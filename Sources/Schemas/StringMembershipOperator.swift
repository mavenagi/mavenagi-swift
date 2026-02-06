import Foundation

/// Operators for string set membership
public enum StringMembershipOperator: String, Codable, Hashable, CaseIterable, Sendable {
    /// Value is in the set (∈)
    case `in` = "IN"
    /// Value is not in the set (∉)
    case notIn = "NOT_IN"
}