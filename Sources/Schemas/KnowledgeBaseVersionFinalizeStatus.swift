import Foundation

/// How the knowledge base version processing ended.
public enum KnowledgeBaseVersionFinalizeStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case succeeded = "SUCCEEDED"
    case failed = "FAILED"
    /// Processing stopped before completing because it was cancelled, rather than because it
    /// failed.
    case canceled = "CANCELED"
}