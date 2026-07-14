import Foundation

/// The indexing status of the knowledge base version
public enum KnowledgeBaseIndexingStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case building = "BUILDING"
    case indexing = "INDEXING"
    case indexed = "INDEXED"
    case published = "PUBLISHED"
    case rollingBack = "ROLLING_BACK"
    case failed = "FAILED"
    case superseded = "SUPERSEDED"
    case rolledBack = "ROLLED_BACK"
}