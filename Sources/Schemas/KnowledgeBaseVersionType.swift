import Foundation

/// The type of knowledge base version
public enum KnowledgeBaseVersionType: String, Codable, Hashable, CaseIterable, Sendable {
    case full = "FULL"
    case partial = "PARTIAL"
}