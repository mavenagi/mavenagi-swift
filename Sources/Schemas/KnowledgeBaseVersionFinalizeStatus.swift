import Foundation

/// Whether the knowledge base version processing was successful or not.
public enum KnowledgeBaseVersionFinalizeStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case succeeded = "SUCCEEDED"
    case failed = "FAILED"
}