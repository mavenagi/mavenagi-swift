import Foundation

/// The status of the knowledge base version
public enum KnowledgeBaseVersionStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case succeeded = "SUCCEEDED"
    case failed = "FAILED"
    case inProgress = "IN_PROGRESS"
}