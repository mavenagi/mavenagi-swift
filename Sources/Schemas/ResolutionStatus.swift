import Foundation

public enum ResolutionStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case resolved = "RESOLVED"
    case escalated = "ESCALATED"
    case inProgress = "IN_PROGRESS"
}