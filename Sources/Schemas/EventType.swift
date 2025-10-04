import Foundation

public enum EventType: String, Codable, Hashable, CaseIterable, Sendable {
    case user = "USER"
    case system = "SYSTEM"
}