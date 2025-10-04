import Foundation

public enum KnowledgeDocumentField: String, Codable, Hashable, CaseIterable, Sendable {
    case title = "Title"
    case createdAt = "CreatedAt"
    case updatedAt = "UpdatedAt"
    case language = "Language"
}