import Foundation

/// Outcome of an action execution.
public enum ActionExecutionStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case success = "SUCCESS"
    case error = "ERROR"
}