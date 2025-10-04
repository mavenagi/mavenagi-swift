import Foundation

public enum AgentUserField: String, Codable, Hashable, CaseIterable, Sendable {
    case createdAt = "CreatedAt"
    case updatedAt = "UpdatedAt"
}