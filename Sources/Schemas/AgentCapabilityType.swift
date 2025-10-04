import Foundation

public enum AgentCapabilityType: String, Codable, Hashable, CaseIterable, Sendable {
    case action = "ACTION"
    case trigger = "TRIGGER"
}