import Foundation

public enum InboxItemSeverity: String, Codable, Hashable, CaseIterable, Sendable {
    case low = "LOW"
    case medium = "MEDIUM"
    case high = "HIGH"
}