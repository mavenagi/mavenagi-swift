import Foundation

public enum VisibilityType: String, Codable, Hashable, CaseIterable, Sendable {
    case visible = "VISIBLE"
    case partiallyVisible = "PARTIALLY_VISIBLE"
    case hidden = "HIDDEN"
}