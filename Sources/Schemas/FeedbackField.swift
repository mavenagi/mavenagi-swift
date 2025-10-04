import Foundation

public enum FeedbackField: String, Codable, Hashable, CaseIterable, Sendable {
    case type = "Type"
    case createdBy = "CreatedBy"
    case createdAt = "CreatedAt"
    case app = "App"
}