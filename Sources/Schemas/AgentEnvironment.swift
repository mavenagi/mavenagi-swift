import Foundation

public enum AgentEnvironment: String, Codable, Hashable, CaseIterable, Sendable {
    case demo = "DEMO"
    case staging = "STAGING"
    case production = "PRODUCTION"
}