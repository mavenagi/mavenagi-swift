import Foundation

/// Operators for numeric set membership
public enum NumericMembershipOperator: String, Codable, Hashable, CaseIterable, Sendable {
    /// Value is in the set (∈)
    case `in` = "IN"
    /// Value is not in the set (∉)
    case notIn = "NOT_IN"
}