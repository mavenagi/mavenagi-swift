import Foundation

/// API knowledge bases are managed by a Maven App.
/// All other knowledge base types are deprecated and can not be created.
public enum KnowledgeBaseType: String, Codable, Hashable, CaseIterable, Sendable {
    /// Shown in Agent Designer as "Maven app".
    case api = "API"
    case url = "URL"
    case manual = "MANUAL"
    /// No longer returned. RSS knowledge bases are `LEGACY`; filtering on `RSS` still matches them.
    case rss = "RSS"
    case legacy = "LEGACY"
}