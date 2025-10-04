import Foundation

public enum PreconditionGroupOperator: String, Codable, Hashable, CaseIterable, Sendable {
    case and = "AND"
    case or = "OR"
}