import Foundation

public enum TimeInterval: String, Codable, Hashable, CaseIterable, Sendable {
    case hour = "HOUR"
    case day = "DAY"
    case week = "WEEK"
    case month = "MONTH"
    case year = "YEAR"
}