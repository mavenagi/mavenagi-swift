import Foundation

/// The status of the knowledge base version
public enum KnowledgeBaseVersionStatus: String, Codable, Hashable, CaseIterable, Sendable {
    /// Shown in Agent Designer as "Success".
    case succeeded = "SUCCEEDED"
    case failed = "FAILED"
    /// Shown in Agent Designer as "Processing".
    case inProgress = "IN_PROGRESS"
    /// Stopped before completing, by a cancel request rather than a failure.
    case canceled = "CANCELED"
}