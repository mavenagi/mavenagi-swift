import Foundation

public enum ResponseLength: String, Codable, Hashable, CaseIterable, Sendable {
    case short = "SHORT"
    case medium = "MEDIUM"
    case long = "LONG"
}