import Foundation

/// API knowledge bases are managed by a Maven App.
/// All other knowledge base types are deprecated and can not be created.
public enum KnowledgeBaseType: String, Codable, Hashable, CaseIterable, Sendable {
    case api = "API"
    case url = "URL"
    case manual = "MANUAL"
    case rss = "RSS"
    case legacy = "LEGACY"
}