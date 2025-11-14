import Foundation

/// The current processing status of the knowledge document
public enum KnowledgeDocumentStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case succeeded = "SUCCEEDED"
    case inProgress = "IN_PROGRESS"
}