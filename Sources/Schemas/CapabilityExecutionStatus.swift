import Foundation

/// Where an execution stands. RUNNING covers both "in flight" and "outcome never recorded", so
/// an execution that stays RUNNING well past its timeout should be read as outcome unknown.
public enum CapabilityExecutionStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case running = "RUNNING"
    case success = "SUCCESS"
    case failed = "FAILED"
}