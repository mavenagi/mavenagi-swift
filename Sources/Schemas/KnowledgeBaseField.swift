import Foundation

public enum KnowledgeBaseField: String, Codable, Hashable, CaseIterable, Sendable {
    case title = "Title"
    case createdAt = "CreatedAt"
    case updatedAt = "UpdatedAt"
}