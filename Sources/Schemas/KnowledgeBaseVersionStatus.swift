import Foundation

/// The status of the knowledge base version
public enum KnowledgeBaseVersionStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case succeeded = "SUCCEEDED"
    case failed = "FAILED"
    case inProgress = "IN_PROGRESS"
    /// Stopped before completing, by a cancel request rather than a failure.
    case canceled = "CANCELED"
}