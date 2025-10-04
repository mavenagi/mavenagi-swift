import Foundation

public enum Quality: String, Codable, Hashable, CaseIterable, Sendable {
    case good = "GOOD"
    case needsImprovement = "NEEDS_IMPROVEMENT"
    case unknown = "UNKNOWN"
}