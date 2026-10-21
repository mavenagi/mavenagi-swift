import Foundation

/// The indexing status of the knowledge base version. In the Agent Designer "Refresh Log", `BUILDING`, `INDEXING` and `INDEXED` show as "Syncing", `PUBLISHED` as "Synced", and `SUPERSEDED`, `ROLLING_BACK` and `ROLLED_BACK` as "Interrupted".
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