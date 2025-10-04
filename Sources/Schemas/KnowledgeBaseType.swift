import Foundation

/// API knowledge bases are managed by a Maven App.
public enum KnowledgeBaseType: String, Codable, Hashable, CaseIterable, Sendable {
    case api = "API"
}