import Foundation

/// The type of the knowledge document content. Markdown preferred.
public enum KnowledgeDocumentContentType: String, Codable, Hashable, CaseIterable, Sendable {
    case html = "HTML"
    case markdown = "MARKDOWN"
}