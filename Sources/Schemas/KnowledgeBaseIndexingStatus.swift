import Foundation

/// The indexing status of the knowledge base version
public enum KnowledgeBaseIndexingStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case building = "BUILDING"
    case indexing = "INDEXING"
    case indexed = "INDEXED"
    case published = "PUBLISHED"
    case failed = "FAILED"
    case superseded = "SUPERSEDED"
}