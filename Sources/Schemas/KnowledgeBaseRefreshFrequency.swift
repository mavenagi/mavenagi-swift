import Foundation

public enum KnowledgeBaseRefreshFrequency: String, Codable, Hashable, CaseIterable, Sendable {
    case none = "NONE"
    case daily = "DAILY"
    case weekly = "WEEKLY"
    case monthly = "MONTHLY"
}