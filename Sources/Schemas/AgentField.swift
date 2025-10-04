import Foundation

public enum AgentField: String, Codable, Hashable, CaseIterable, Sendable {
    case createdAt = "CREATED_AT"
    case environment = "ENVIRONMENT"
}