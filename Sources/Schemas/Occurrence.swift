import Foundation

/// A numbered occurrence within a month.
public enum Occurrence: String, Codable, Hashable, CaseIterable, Sendable {
    case first = "FIRST"
    case second = "SECOND"
    case third = "THIRD"
    case fourth = "FOURTH"
    /// The final occurrence in the month, whether that is the fourth or the fifth.
    case last = "LAST"
}