import Foundation

public enum AgentCapabilityField: String, Codable, Hashable, CaseIterable, Sendable {
    case createdAt = "CreatedAt"
    case enabled = "Enabled"
    case name = "Name"
    case type = "Type"
    case userInteractionRequired = "UserInteractionRequired"
}